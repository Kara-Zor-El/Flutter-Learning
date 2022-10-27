import 'package:flutter/material.dart';
import './calculator.dart';
import './settings.dart';

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
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: const [
        Calculator(),
      ],
    );
    // Settings(updateColor: updateColor, updateTrollMode: updateTrollMode),
  }

  void changeSceneIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void updateColor() {
    setState(() {
      buttonColor = buttonColor;
      textColor = textColor;
    });
  }

  void updateTrollMode() {
    setState(() {
      trollMode;
    });
  }
}
