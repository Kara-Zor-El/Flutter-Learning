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

  Color? textColor;
  Color? buttonColor;
  bool trollMode = false;
  void setPrefs() async {
    final Map<String, Color> colors = {
      'purple': Colors.purple,
      'blue': Colors.blue,
      'white': Colors.white,
      'brown': Colors.brown,
      'teal': Colors.teal,
      'orange': Colors.orange,
    };
    final prefs = await SharedPreferences.getInstance();
    textColor = colors[prefs.getString('textColor')];
    buttonColor = colors[prefs.getString('buttonColor')];
    try {
      prefs.getBool('trollMode');
      trollMode = prefs.getBool('trollMode')!;
    } catch (e) {
      trollMode = false;
    }
    setState(() {});
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
