import 'package:flutter/material.dart';
import './calculator.dart';
import './navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.brown, scaffoldBackgroundColor: Colors.black),
      home: const MyCalculatorApp(),
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
    if (index == 0) {
      return Column(
        children: [
          const Calculator(),
          MyNavbar(
            onClick: changeSceneIndex,
            curIndex: index,
          ),
        ],
      );
    } else if (index == 1) {
      return Column(
        children: [
          const Text("Welcome to the settings screen"),
          MyNavbar(
            onClick: changeSceneIndex,
            curIndex: index,
          ),
        ],
      );
    }
    return Container();
  }

  void changeSceneIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }
}
