import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './calculator.dart';
import './settings.dart';
import 'notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: const MyCalculatorApp(),
      routes: <String, WidgetBuilder>{
        '/settings': (BuildContext context) => const Settings(),
        '/notes': (BuildContext context) => const Notes(),
      },
    );
  }
}

class MyCalculatorApp extends StatefulWidget {
  const MyCalculatorApp({super.key});

  @override
  State<MyCalculatorApp> createState() => _MyCalculatorAppState();
}

class _MyCalculatorAppState extends State<MyCalculatorApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: const [
        Calculator(),
      ],
    );
  }
}
