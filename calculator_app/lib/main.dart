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

  void addToString(String s) {
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
    if (!checkForErrors(s)) {
      newString = "Error! Try again.";
    } else {
      newString = calculateString(s);
    }
    setState(() {
      displayString = newString;
    });
  }

  String calculateString(String s) {
    if (s.contains("(")) {
    } else if (s.contains("÷")) {
    } else if (s.contains("x")) {
    } else if (s.contains("+")) {
    } else if (s.contains("-")) {}

    return "Result: " + s;
  }

  bool checkForErrors(String s) {
    int counter = 0;
    for (int i = 0; i < s.length; i++) {
      if (s[i] == '(') {
        counter++;
      } else if (s[i] == ')') {
        counter--;
      }
      if (counter < 0) break;
    }
    if (counter != 0) {
      return false;
    } else {
      return true;
    }
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
              child: Text(
                displayString,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(20, 125, 20, 0),
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
                    buttonConstructor(text: "7", pV: 10, mT: 15),
                    buttonConstructor(text: "8", pV: 10, mT: 15),
                    buttonConstructor(text: "9", pV: 10, mT: 15),
                    buttonConstructor(text: "-", pH: 32, pV: 20),
                  ],
                ),
                Row(
                  children: [
                    buttonConstructor(text: "4", pV: 10, mT: 15),
                    buttonConstructor(text: "5", pV: 10, mT: 15),
                    buttonConstructor(text: "6", pV: 10, mT: 15),
                    buttonConstructor(text: "+", pH: 30, pV: 20),
                  ],
                ),
                Row(
                  children: [
                    buttonConstructor(text: "1", pV: 10, mT: 15),
                    buttonConstructor(text: "2", pV: 10, mT: 15),
                    buttonConstructor(text: "3", pV: 10, mT: 15),
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
