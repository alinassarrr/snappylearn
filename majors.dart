import 'package:flutter/material.dart';
import 'courses.dart';

class Majors extends StatefulWidget {
  @override
  _MajorsState createState() => _MajorsState();
}

class _MajorsState extends State<Majors> {
  final Map<String, Map<String, Widget>> majorCourses = {
    'Computer Science': {
      'OS': CoursePage(
        courseName: 'OS',
        coursePages: {}, 
        onCourseFavoriteToggle: (courseName) {},
      ),
      'WEB': CoursePage(
        courseName: 'WEB',
        coursePages: {}, 
        onCourseFavoriteToggle: (courseName) {},
      ),
      'MOBILEAPP': CoursePage(
        courseName: 'MOBILEAPP',
        coursePages: {}, 
        onCourseFavoriteToggle: (courseName) {},
      ),
    },
    'Electrical Engineering': {
      'ENG200': CoursePage(
        courseName: 'ENG200',
        coursePages: {}, 
        onCourseFavoriteToggle: (courseName) {},
      ),
      'ENG400': CoursePage(
        courseName: 'ENG400',
        coursePages: {}, 
        onCourseFavoriteToggle: (courseName) {},
      ),
      'ENG678': CoursePage(
        courseName: 'ENG678',
        coursePages: {}, 
        onCourseFavoriteToggle: (courseName) {},
      ),
      'ENG300': CoursePage(
        courseName: 'ENG300',
        coursePages: {}, 
        onCourseFavoriteToggle: (courseName) {},
      ),
    },
  };

  Set<String> favoritedCourses = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Majors At LIU'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 187, 95, 182),
              ),
              child: Center(
                child: Text(
                  'MyCourses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ...favoritedCourses.map((item) => ListTile(
                  title: Center(child: Text(item)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => majorCourses.entries
                            .expand((majorEntry) => majorEntry.value.entries
                                .map((courseEntry) => courseEntry.value))
                            .firstWhere(
                              (coursePage) =>
                                  (coursePage as CoursePage).courseName == item,
                            ),
                      ),
                    );
                  },
                )),
          ],
        ),
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
                    builder: (context) => CoursePage(
                      courseName: major,
                      coursePages: majorCourses[major]!,
                      onCourseFavoriteToggle: (courseName) {
                        // Toggle the course's favorite status
                        setState(() {
                          if (favoritedCourses.contains(courseName)) {
                            favoritedCourses.remove(courseName);
                          } else {
                            favoritedCourses.add(courseName);
                          }
                        });
                      },
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
                fixedSize: Size(200, 150),
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
