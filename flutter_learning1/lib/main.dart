// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

void main() => runApp((MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': ['Blue', 'Red', 'Green', 'Yellow']
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': ['Tiger', 'Dog', 'Cat', 'Elephant', 'Monkey']
    },
    {
      'questionText': 'Who\'s your favorite programmer?',
      'answers': ['Parsa', 'Parsa', 'Parsa']
    },
  ];

  var _qIndex = 0;

  void _answerQuestion() {
    setState(() {
      _qIndex++;
    });
    print("An answer has been chosen!");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 83, 0),
          title: const Text('My First App!'),
        ),
        body: _qIndex < questions.length
            ? Column(
                children: [
                  Question(
                    questions[_qIndex]['questionText'].toString(),
                  ),
                  ...(questions[_qIndex]['answers'] as List<String>)
                      .map((answer) {
                    return Answer(_answerQuestion, answer);
                  }).toList()
                ],
              )
            : Center(
                child: Text('You did it! You\'re done!'),
              ),
      ),
    );
  }
}
