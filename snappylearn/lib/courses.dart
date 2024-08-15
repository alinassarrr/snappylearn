import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'flipcard.dart';

class CoursePage extends StatefulWidget {
  final String courseName;
  final Map<String, Widget> coursePages;
  final Function(String) onCourseFavoriteToggle;
  final String userId;

  CoursePage({
    required this.courseName,
    required this.coursePages,
    required this.onCourseFavoriteToggle,
    required this.userId,
  });

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursePage> {
  Set<String> favoritedCourses = Set<String>();

  Future<void> _toggleFavorite(String courseName, bool isFavorited) async {
    String apiUrl = isFavorited
        ? 'https://snappylearn.000webhostapp.com/unfavorite.php'
        : 'https://snappylearn.000webhostapp.com/save_favorite_course.php';

    Map<String, dynamic> requestData = {
      'user_id': widget.userId,
      'course_name': courseName,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200 && response.body == '1') {
        // Successful toggle
        widget.onCourseFavoriteToggle(courseName);
      } else {
        // Handle error
        print('Error during toggle. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Error during toggle: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'Courses of - ${widget.courseName}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
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
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: widget.coursePages.length,
        itemBuilder: (context, index) {
          var courseName = widget.coursePages.keys.elementAt(index);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Flip(
                      courseName: courseName,
                      onPointsClaimed: (int index) {
                        setState(() {});
                      },
                      userId: widget.userId,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                side: BorderSide(color: Colors.black),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                fixedSize: Size(200, 125),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      courseName,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: favoritedCourses.contains(courseName)
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      onPressed: () {
                        _toggleFavorite(courseName, favoritedCourses.contains(courseName));
                      },
                      color: Color.fromARGB(255, 187, 95, 182),
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
