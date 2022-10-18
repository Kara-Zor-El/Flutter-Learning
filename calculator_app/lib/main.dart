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
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayString = "";
  Widget buttonConstructor({
    String text = "",
    double mL = 8,
    double mT = 5,
    double mR = 0,
    double mB = 0,
    double pH = 35,
    double pV = 0,
    bool isEquals = false,
    bool isCE = false,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(mL, mT, mR, mB),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: pH, vertical: pV),
        ),
        onPressed: !isEquals && !isCE
            ? () => addToString(text)
            : isEquals
                ? () => calculateSequence(displayString)
                : () => clearEverything(),
        child: Text(
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          text,
        ),
      ),
    );
  }

  ScrollController _scrollController = ScrollController();
  _scrollToRight() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 1),
      curve: Curves.easeOut,
    );
  }

  void addToString(String s) {
    _scrollToRight();
    setState(() {
      displayString += s;
    });
  }

  void clearEverything() {
    setState(() {
      displayString = "";
    });
  }

  void calculateSequence(String s) {
    String newString = s;
    String error = checkForErrors(s);
    if (error != "FALSE") {
      newString = error;
    } else {
      newString = calculateString(s);
    }
    setState(() {
      displayString = "= $newString";
    });
  }

  String calculateString(String s) {
    if (s.contains("(")) {
      int startingIndex = s.indexOf("(");
      int endingIndex = s.indexOf(")");
      String formula = s.substring(startingIndex + 1, endingIndex);
      formula = calculateString(formula);
      return calculateString((endingIndex + 1 != s.length)
          ? s.substring(0, startingIndex) +
              formula +
              s.substring(endingIndex + 1)
          : s.substring(0, startingIndex) + formula);
    } else if (s.contains("÷")) {
    } else if (s.contains("x")) {
    } else if (s.contains("+")) {
    } else if (s.contains("-")) {}

    return s;
  }

  String checkForErrors(String s) {
    int counter = 0;
    for (int i = 0; i < s.length; i++) {
      // Check for invalid brackets
      if (s[i] == '(') {
        counter++;
      } else if (s[i] == ')') {
        counter--;
      }
      if (counter < 0) break;
    }
    if (counter != 0) {
      return "Invalid Brackets. Try again";
    }

    for (int i = 0; i < s.length - 1; i++) {
      // Check for closing bracket next to opening bracket.
      if (s[i] == ')' && s[i + 1] == '(' || s[i] == '(' && s[i + 1] == ')') {
        return "Two brackets next to each other is not allowed.";
      }
    }

    return "FALSE";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Calculator!'),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                style: const TextStyle(fontSize: 30),
                displayString,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            padding: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    buttonConstructor(text: "x"),
                    buttonConstructor(text: "÷"),
                    buttonConstructor(text: "("),
                    buttonConstructor(text: ")"),
                  ],
                ),
                Row(
                  children: [
                    buttonConstructor(text: "7", pV: 13, mT: 15),
                    buttonConstructor(text: "8", pV: 13, mT: 15),
                    buttonConstructor(text: "9", pV: 13, mT: 15),
                    buttonConstructor(text: "-", pH: 32, pV: 20),
                  ],
                ),
                Row(
                  children: [
                    buttonConstructor(text: "4", pV: 13, mT: 15),
                    buttonConstructor(text: "5", pV: 13, mT: 15),
                    buttonConstructor(text: "6", pV: 13, mT: 15),
                    buttonConstructor(text: "+", pH: 30, pV: 20),
                  ],
                ),
                Row(
                  children: [
                    buttonConstructor(text: "1", pV: 13, mT: 15),
                    buttonConstructor(text: "2", pV: 13, mT: 15),
                    buttonConstructor(text: "3", pV: 13, mT: 15),
                    buttonConstructor(
                        text: "=", pH: 30, pV: 20, isEquals: true),
                  ],
                ),
                Row(children: [
                  buttonConstructor(
                      text: "Clear Everything",
                      pV: 10,
                      pH: 84,
                      mT: 15,
                      isCE: true),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
