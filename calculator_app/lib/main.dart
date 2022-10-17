import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Best Calculator!',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget buttonConstructor({
    String text = "",
    double mL = 10,
    double mT = 5,
    double mR = 0,
    double mB = 0,
    double pH = 35,
    double pV = 0,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(mL, mT, mR, mB),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: pH, vertical: pV),
        ),
        onPressed: null,
        child: Text(
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text(
                "Nothing So Far!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(20, 100, 20, 0),
            padding: const EdgeInsets.only(bottom: 250),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                buttonConstructor(text: "X"),
                buttonConstructor(text: "÷"),
                buttonConstructor(text: "("),
                buttonConstructor(text: ")"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
