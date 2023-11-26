import 'package:flutter/material.dart';
import 'courses.dart';

class Majors extends StatelessWidget {
  final Map<String, Map<String, Widget>> majorCourses = {

    'Computer Science': {
      'OS': CoursePage(courseName: 'OS'),
      'WEB': CoursePage(courseName: 'WEB'),
      'MOBILEAPP': CoursePage(courseName: 'MOBILEAPP'),
    },
    'Electrical Engineering': {
      'ENG200': CoursePage(courseName: 'ENG200'),
      'ENG400': CoursePage(courseName: 'ENG400'),
      'ENG678': CoursePage(courseName: 'ENG678'),
      'ENG300': CoursePage(courseName: 'ENG300'),
    },
    
    // Add more majors and their courses as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Majors At LIU'),
      ),
      body: ListView.builder(
        itemCount: majorCourses.length,
        itemBuilder: (context, index) {
          var major = majorCourses.keys.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoursesPage(
                      major: major,
                      coursePages: majorCourses[major]!,
                    ),
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
                major,
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
