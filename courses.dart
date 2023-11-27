import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  final String major;
  final Map<String, Widget> coursePages;
  final Function(String) onCourseFavoriteToggle;

  CoursesPage(
      {required this.major,
      required this.coursePages,
      required this.onCourseFavoriteToggle});

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  // A set to keep track of favorited courses
  Set<String> favoritedCourses = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses of - ${widget.major}'),
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
                    builder: (context) => widget.coursePages[courseName]!,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 128, 204, 141),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                fixedSize: Size(200, 125), // Set the size as needed
              ),
              child: Stack(
                children: [
                  // Centered course name
                  Center(
                    child: Text(
                      courseName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Star button at bottom right
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: favoritedCourses.contains(courseName)
                          ? Icon(Icons.star)
                          : Icon(Icons.star_border),
                      onPressed: () {
                        // Toggle the course's favorite status
                        widget.onCourseFavoriteToggle(courseName);

                        setState(() {
                          if (favoritedCourses.contains(courseName)) {
                            favoritedCourses.remove(courseName);
                          } else {
                            favoritedCourses.add(courseName);
                          }
                        });
                      },
                      color: Colors.yellow,
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

class CoursePage extends StatelessWidget {
  final String courseName;

  CoursePage({required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course - $courseName'),
      ),
      body: Center(
        child: Text(
          'Content for $courseName goes here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
