import 'package:calculator_app/sign_up.dart';
import 'package:calculator_app/login.dart';
import 'package:flutter/material.dart';
import './calculator.dart';
import './settings.dart';
import './converter.dart';
import './notes.dart';
import './utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        '/converter': (BuildContext context) => const Converter(),
        '/signup': (BuildContext context) => const SignUp(),
        '/calculator': (BuildContext context) => const Calculator()
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
    setPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: const [
        LoginScreen(),
      ],
    );
  }
}
