import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Flip extends StatefulWidget {
  final String courseName;
  final VoidCallback onPointsClaimed;

  Flip({required this.courseName, required this.onPointsClaimed});

  @override
  _FlipState createState() => _FlipState();
}

class _FlipState extends State<Flip> {
  int totalPoints = 0;
  List<bool> buttonClickedList = List.generate(3, (index) => false);
  List<String> frontTexts = [
    'Deadlock',
    'Process Synchronization',
    'Threads',
  ];

  List<String> backTexts = [
    "A set of blocked processes each holding a resource and waiting to acquire a resource held by another process in the set. Example: System has 2 disk drives P1 and P2, each holds one disk drive and each needs another one.",
    "Process Synchronization is the coordination of execution of multiple processes in a multi-process system to ensure that they access shared resources in a controlled and predictable manner. It aims to resolve the problem of race conditions and other synchronization issues in a concurrent system.",
    "Threads are sequences of instructions given to the CPU, and threading techniques like multithreading and hyperthreading can improve performance. In operating system terms, threads are the smallest unit of execution within a process, allowing multiple tasks to be performed concurrently by the CPU.",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flash Cards - ${widget.courseName}'),
          actions: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    'Total Points: $totalPoints',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return FlipCard(
              direction: FlipDirection.HORIZONTAL,
              flipOnTouch: true,
              front: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  color: Colors.blue,
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
                  border: Border.all(color: Colors.black, width: 2.0),
                  color: Colors.green,
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
                              color: Colors.black,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    Positioned(
                      bottom: 10,
                      child: ElevatedButton(
                        onPressed: buttonClickedList[index]
                            ? null
                            : () {
                                widget.onPointsClaimed();
                                setState(() {
                                  totalPoints += 20;
                                  buttonClickedList[index] = true;
                                });
                              },
                        child: Text('Claim 20 pts'),
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
