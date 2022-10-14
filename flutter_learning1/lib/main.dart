// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp((MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Blue', 'score': 1},
        {'text': 'Red', 'score': 4},
        {'text': 'Green', 'score': 2},
        {'text': 'Black', 'score': 10}
      ]
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Tiger', 'score': 4},
        {'text': 'Dog', 'score': 1},
        {'text': 'Cat', 'score': 0},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Monkey', 'score': 8}
      ]
    },
    {
      'questionText': 'Who\'s your favorite programmer?',
      'answers': [
        {'text': 'Parsa', 'score': 0},
        {'text': 'Parsa', 'score': 0},
        {'text': 'Parsa', 'score': 0}
      ]
    },
  ];

  var _qIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;

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
        body: _qIndex < _questions.length
            ? Quiz(_answerQuestion, _questions, _qIndex)
            : Result(),
      ),
    );
  }
}
