import 'package:flutter/material.dart';
import 'flipcard.dart'; 
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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school,
                color: Colors.white,
              ),
              SizedBox(width: 15),
              Text(
                'Majors At LIU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 187, 95, 182), // First color
                Color.fromARGB(255, 115, 103, 240), // Second color
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
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
                  title: Center(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: Color.fromARGB(255, 115, 103, 240),
                            width: 2.0),
                        color: Color.fromARGB(255, 115, 103, 240),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Flip(
                          courseName: item,
                     
                          onPointsClaimed: () {
                            setState(() {});
                          },
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
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                side: BorderSide(color: Colors.black),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                fixedSize: Size(200, 150),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 120),
                      Center(
                        child: Text(
                          major,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (major == 'Computer Science')
                        Icon(
                          Icons.laptop,
                          size: 40,
                          color: Colors.black,
                        ),
                      if (major == 'Electrical Engineering')
                        Icon(
                          Icons.engineering,
                          size: 40,
                          color: Colors.black,
                        ),
                    ],
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
