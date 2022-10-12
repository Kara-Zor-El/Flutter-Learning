import 'package:flutter/material.dart';

void main() => runApp((MyApp()));

class MyApp extends StatelessWidget {
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
          children: const [
            Text('Yep yep text'),
            ElevatedButton(
              child: Text('First'),
              onPressed: null,
            ),
            ElevatedButton(
              child: Text('Second'),
              onPressed: null,
            ),
            ElevatedButton(
              child: Text('Third'),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
