// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp((MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _qIndex = 0;

  void _answerQuestion() {
    setState(() {
      _qIndex++;
    });
    print("An answer has been chosen!");
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      'What\'s your favorite color?',
      'What\'s your favorite animal?',
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 83, 0),
          title: const Text('My First App!'),
        ),
        body: Column(
          children: [
            Text(questions[_qIndex]),
            ElevatedButton(
              child: Text('First'),
              onPressed: _answerQuestion,
            ),
            ElevatedButton(
              child: Text('Second'),
              onPressed: () => print("Yep that is the second answer"),
            ),
            ElevatedButton(
              child: Text('Third'),
              onPressed: () {
                print("Nice, you pressed the third button");
              },
            ),
          ],
        ),
      ),
    );
  }
}
