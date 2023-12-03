import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Flip extends StatefulWidget {
  final String courseName;
  final  Function() onPointsClaimed;

  Flip({
    required this.courseName,
    required this.onPointsClaimed,
  });

  @override
  _FlipState createState() => _FlipState();
}

class _FlipState extends State<Flip> {
  static int totalPoints = 0;
  static Set<String> clickedButtons = {};

  List<String> frontTexts = [];
  List<String> backTexts = [];

  @override
  void initState() {
    super.initState();
     
            if (widget.courseName == 'OS') {
              frontTexts = [
                'Understanding Deadlocks',
                'Concurrency and Parallelism',
                'Memory Management in OS',
              ];
              backTexts = [
                'A deadlock occurs when each process in a set is blocked, each waiting for a resource acquired by another process in the set.',
                'Concurrency allows multiple tasks to be executed in overlapping time periods, while parallelism involves the simultaneous execution of multiple tasks.',
                'Memory management in OS involves tracking each byte in a computer\'s memory and managing the allocation and deallocation of memory spaces as needed.',
              ];
            } else if (widget.courseName == 'WEB') {
              frontTexts = [
                'Introduction to Web Development',
                'Frontend Technologies',
                'Backend Technologies',
              ];
              backTexts = [
                'Web development involves building and maintaining websites, encompassing web design, web content development, client-side/server-side scripting, and network security configuration.',
                'Frontend technologies include HTML, CSS, and JavaScript, focusing on the user interface and user experience of a website.',
                'Backend technologies handle the server-side logic, databases, and application architecture, ensuring data management and business logic execution.',
              ];
            } else if (widget.courseName == 'MOBILEAPP') {
              frontTexts = [
                'Mobile App Development Basics',
                'iOS App Development',
                'Android App Development2',
                'Android App Development',
              ];
              backTexts = [
                'Mobile app development involves creating software applications that run on mobile devices, covering various platforms such as iOS and Android.',
                'iOS app development focuses on creating applications for Apple\'s iOS devices, using programming languages like Swift and Objective-C.',
                'Android app development involves creating applications for the Android operating system, using programming languages like Java and Kotlin.',
                'Android app development involves creating applications for the Android operating system, using programming languages like Java and Kotlin.',
              ];
            
          } 
            if (widget.courseName == 'ENG200') {
              frontTexts = [
                'Introduction to Electrical Engineering',
                'Circuit Analysis Basics',
                'Electronic Components Overview',
              ];
              backTexts = [
                'This course provides an introduction to the fundamentals of electrical engineering.',
                'Learn the basics of circuit analysis and understand electrical circuits.',
                'Explore different electronic components and their functions.',
              ];
            } else if (widget.courseName == 'ENG400') {
              frontTexts = [
                'Power Systems Engineering',
                'Renewable Energy Integration',
                'Electric Machines and Drives',
              ];
              backTexts = [
                'Study the design and operation of power systems in electrical engineering.',
                'Explore the integration of renewable energy sources into power systems.',
                'Learn about electric machines and their applications in drives.',
              ];
            } else if (widget.courseName == 'ENG678') {
              frontTexts = [
                'Control Systems Engineering',
                'Digital Signal Processing',
                'Communication Systems',
              ];
              backTexts = [
                'Explore the principles and applications of control systems in engineering.',
                'Study digital signal processing techniques and their applications.',
                'Learn about communication systems and signal transmission.',
              ];
            } else if (widget.courseName == 'ENG300') {
              frontTexts = [
                'Electromagnetic Fields and Waves',
                'Microelectronics',
                'Power Electronics',
              ];
              backTexts = [
                'Understand electromagnetic fields and their behavior in waves.',
                'Explore the principles of microelectronics and integrated circuits.',
                'Study the application of electronics in power systems.',
              ];
            
          }

    totalPoints = getTotalPoints();
    clickedButtons = getClickedButtons();
  }

  int getTotalPoints() {
    return totalPoints;
  }

  Set<String> getClickedButtons() {
    return clickedButtons;
  }

  void setTotalPoints(int points) {
    totalPoints = points;
  }

  void setClickedButtons(Set<String> buttons) {
    clickedButtons = buttons;
  }

  void onPointsClaimed(int index) {
    setState(() {
      totalPoints += 20;
      clickedButtons.add('$index');
    });
  }

  void saveState() {
    setTotalPoints(totalPoints);
    setClickedButtons(clickedButtons);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Flash Cards - ${widget.courseName}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    'Total Points: $totalPoints',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              saveState();
              Navigator.pop(context);
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
                      Color.fromARGB(255, 187, 95, 182), // First color
                      Color.fromARGB(255, 115, 103, 240), // Second color
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
                          backgroundColor: clickedButtons.contains('$index')
                              ? Colors.grey
                              : Colors.white,
                        ),
                        onPressed: clickedButtons.contains('$index')
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
