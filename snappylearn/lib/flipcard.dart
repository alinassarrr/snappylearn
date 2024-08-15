import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Flip extends StatefulWidget {
  final String courseName;
  final Null Function(int index) onPointsClaimed;
  final String userId;

  Flip({
    required this.courseName,
    required this.onPointsClaimed,
    required this.userId,
  });
  @override
  _FlipState createState() => _FlipState();
}

class _FlipState extends State<Flip> {
  static Map<String, Set<String>> courseClickedButtons = {};
  List<String> frontTexts = [];
  List<String> backTexts = [];

  @override
  void initState() {
    super.initState();
    initializeCourseData();
  }

  void initializeCourseData() async {
    final response = await http.get(
      Uri.parse('https://snappylearn.000webhostapp.com/get_course_content.php?course_name=${widget.courseName}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      frontTexts = List<String>.from(data.map((item) => item['front_text']));
      backTexts = List<String>.from(data.map((item) => item['back_text']));
    } else {
      print('Failed to fetch course content. Error: ${response.body}');
    }

    // Initialize clicked buttons for each course
    courseClickedButtons.putIfAbsent(widget.courseName, () => {});

    // Retrieve total points for the current course
    setState(() {
      frontTexts = [...frontTexts];
      backTexts = [...backTexts];
    });
  }

  void onPointsClaimed(int index) {
    setState(() {
      courseClickedButtons[widget.courseName]!.add('$index');
    });

    // Save points to the database (you need to implement this)
    savePointsToDatabase(widget.userId, widget.courseName, 20);
  }

  void savePointsToDatabase(String userId, String courseName, int points) async {
    final response = await http.post(
      Uri.parse('https://snappylearn.000webhostapp.com/save_points.php'),
      body: {'user_id': userId, 'course_name': courseName, 'points': '$points'},
    );

    if (response.statusCode == 200) {
      print('Points saved successfully');
    } else {
      print('Failed to save points. Error: ${response.body}');
    }
  }

  void saveState() {
    // Save the clicked buttons for the current course
    courseClickedButtons[widget.courseName] = courseClickedButtons[widget.courseName]!;
  }

  Future<int> getTotalPoints(String userId, String courseName) async {
    final response = await http.get(
      Uri.parse('https://snappylearn.000webhostapp.com/get_total_points.php?user_id=$userId&course_name=$courseName'),
    );

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load total points');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: FutureBuilder(
            future: getTotalPoints(widget.userId, widget.courseName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                  'Flash Cards-${widget.courseName} - Total Points: ${snapshot.data}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                );
              }
            },
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              saveState(); // Move saveState here
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 187, 95, 182),
                  Color.fromARGB(255, 115, 103, 240),
                ],
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: backTexts.length,
          itemBuilder: (context, index) {
            if (index >= backTexts.length) {
              return Container();
            }

            return FlipCard(
              direction: FlipDirection.HORIZONTAL,
              flipOnTouch: true,
              front: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 187, 95, 182),
                      Color.fromARGB(255, 115, 103, 240),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Center(
                  child: Text(
                    frontTexts[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              back: Container(
                width: 500,
                height: 400,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 187, 95, 182),
                      Color.fromARGB(255, 115, 103, 240),
                    ],
                  ),
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(15.0),
                          color: Colors.white,
                          child: Text(
                            backTexts[index],
                            style: TextStyle(
                              color: Color.fromARGB(255, 1, 45, 82),
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    Positioned(
                      bottom: 10,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          backgroundColor:
                              courseClickedButtons[widget.courseName]!
                                      .contains('$index')
                                  ? Colors.grey
                                  : Colors.white,
                        ),
                        onPressed: courseClickedButtons[widget.courseName]!
                                .contains('$index')
                            ? null
                            : () {
                                onPointsClaimed(index);
                              },
                        child: Text(
                          'Claim 20pts',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 115, 103, 240),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
