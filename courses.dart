import 'package:flutter/material.dart';


class CoursesPage extends StatelessWidget {
  final String major;
  final Map<String, Widget> coursePages;

  CoursesPage({required this.major, required this.coursePages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses of - $major'),
      ),
      body: ListView.builder(
        itemCount: coursePages.length,
        itemBuilder: (context, index) {
          var courseName = coursePages.keys.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => coursePages[courseName]!,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 128, 204, 141),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              ),
              child: Text(
                courseName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
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
