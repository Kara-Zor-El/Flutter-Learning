import 'package:calculator_app/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyCalculator());
}

class MyCalculator extends StatelessWidget {
  const MyCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Best Calculator!',
      theme: ThemeData(
          primarySwatch: Colors.brown, scaffoldBackgroundColor: Colors.black),
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
  List<String> buttons = [
    "÷",
    "x",
    "(",
    ")",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "=",
    "0",
    "00",
    ".",
    "CE",
  ];

  Widget buttonConstructor({String text = ""}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
      onPressed: () => onPressedHandler(text),
      child: Text(
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: textColor),
        text,
      ),
    );
  }

  void onPressedHandler(String text) {
    if (text == "=") {
      calculateSequence(displayString);
    } else if (text == "CE") {
      clearEverything();
    } else {
      addToString(text);
    }
    if (trollMode) {
      buttons.shuffle();
    }
  }

  final ScrollController _scrollController = ScrollController();
  _scrollToRight() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeOut,
    );
  }

  bool resetOnNew = false;
  void addToString(String s) {
    if (resetOnNew == true) {
      clearEverything();
      resetOnNew = false;
    }
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
    String newString;
    String oldString;
    oldString = s;
    newString = s;
    String error = checkForErrors(s);
    if (error != "FALSE") {
      setState(() {
        displayString = error;
      });
    } else {
      newString = calculateString(s);
      newString = fixSigFigs(newString);
      resetOnNew = true;
      setState(() {
        displayString = "$oldString = $newString";
      });
    }
  }

  String fixSigFigs(String s) {
    for (int i = s.length - 1; i >= s.indexOf(r'\.'); i--) {
      if (s[i] == '0') {
        s = s.substring(0, i);
      } else if (s[i] == '.') {
        s = s.substring(0, i);
        break;
      } else {
        break;
      }
    }

    return s;
  }

  String calculateString(String s) {
    RegExp negativeAnswer = RegExp(r'^-\d+(\.\d+)?$');
    if (s.contains("(")) {
      int startingIndex = s.indexOf("(");
      int endingIndex = s.indexOf(")");
      int counter = 0;
      for (int i = startingIndex + 1; i < s.length; i++) {
        if (s[i] == "(") {
          counter++;
        } else if (s[i] == ")") {
          counter--;
        }
        if (counter < 0) {
          endingIndex = i;
          break;
        }
      }
      String equation = s.substring(startingIndex + 1, endingIndex);
      equation = calculateString(equation);
      return calculateString((endingIndex + 1 != s.length)
          ? s.substring(0, startingIndex) +
              equation +
              s.substring(endingIndex + 1)
          : s.substring(0, startingIndex) + equation);
    } else if (s.contains("÷")) {
      RegExp firstDiv = RegExp(r'(-?)((\d+\.)?\d+÷(-?-?)\d+(\.\d+)?)');
      return calculateString(returnAnswer('÷', firstDiv, s));
    } else if (s.contains("x")) {
      RegExp firstMul = RegExp(r'(-?)((\d+\.)?\d+x(-?-?)\d+(\.\d+)?)');
      return calculateString(returnAnswer('x', firstMul, s));
    } else if (s.contains("+")) {
      RegExp firstPlus = RegExp(r'(-?)((\d+\.)?\d+\+(-?-?)\d+(\.\d+)?)');
      return calculateString(returnAnswer('+', firstPlus, s));
    } else if (s.contains("-") && !negativeAnswer.hasMatch(s)) {
      RegExp firstSub = RegExp(r'(-?)((\d+\.)?\d+-(-?-?)\d+(\.\d+)?)');
      return calculateString(returnAnswer('-', firstSub, s));
    }

    return s;
  }

  String returnAnswer(String operator, RegExp regex, String s) {
    var equationMatch = regex.firstMatch(s);
    try {
      var equation = s.substring(equationMatch!.start, equationMatch.end);
      int symbolIndex;
      if (operator == "-") {
        RegExp midSub = RegExp(r'\d+-(-?)+\d+');
        var firstMatch = midSub.firstMatch(equation);
        var firstMatchString = s.substring(firstMatch!.start, firstMatch.end);
        symbolIndex =
            equation.indexOf(operator, equation.indexOf(firstMatchString));
      } else {
        symbolIndex = equation.indexOf(operator);
      }
      double firstNum = double.parse(equation.substring(0, symbolIndex));
      double secondNum = double.parse(equation.substring(symbolIndex + 1));
      String answer;
      if (operator == '÷') {
        answer = s.substring(0, s.indexOf(equation)) +
            (firstNum / secondNum).toString() +
            s.substring(s.indexOf(equation) + equation.length);
      } else if (operator == 'x') {
        answer = s.substring(0, s.indexOf(equation)) +
            (firstNum * secondNum).toString() +
            s.substring(s.indexOf(equation) + equation.length);
      } else if (operator == '+') {
        answer = s.substring(0, s.indexOf(equation)) +
            (firstNum + secondNum).toString() +
            s.substring(s.indexOf(equation) + equation.length);
      } else if (operator == '-') {
        answer = s.substring(0, s.indexOf(equation)) +
            (firstNum - secondNum).toString() +
            s.substring(s.indexOf(equation) + equation.length);
      } else {
        answer = "NULL";
      }
      print("$equation in $s = $answer");
      return answer;
    } catch (e) {
      return "Error | Not Allowed";
    }
  }

  String checkForErrors(String s) {
    RegExp isSymbol = RegExp(r'[÷x+]');
    RegExp threePlusSub = RegExp(r'---');
    RegExp invalidPeriods = RegExp(
        r'((\.\d+\.\d+[÷x+-])|([÷x+-])\d+\.\d+\.)|(([÷x+-]\.)|(^\.)|(\.$))');
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
      if (isSymbol.hasMatch(s[i]) && isSymbol.hasMatch(s[i + 1])) {
        return "Two symbols next to each other is not allowed.";
      }
    }

    if (threePlusSub.hasMatch(s)) {
      return "Three or more negative signs are not allowed";
    }

    if (invalidPeriods.hasMatch(s)) {
      return "Invalid periods";
    }

    if (resetOnNew) {
      clearEverything();
      return "No equation";
    }

    return "FALSE";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              style: TextStyle(
                fontSize: 25,
                color: textColor,
                decoration: TextDecoration.none,
              ),
              displayString,
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            margin: const EdgeInsets.only(bottom: 30),
            height: (MediaQuery.of(context).size.height) / 1.5,
            alignment: Alignment.bottomCenter,
            child: GridView.count(
                scrollDirection: Axis.vertical,
                mainAxisSpacing: 10,
                crossAxisSpacing: 15,
                childAspectRatio: 1.2,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                crossAxisCount: 4,
                children: [
                  for (int i = 0; i < buttons.length; i++)
                    buttonConstructor(text: buttons[i])
                ]),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/notes')
                      .then((value) => setState(() {})),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.all(5)),
                  child: Column(
                    children: [
                      Icon(
                        color: textColor,
                        Icons.notes_rounded,
                      ),
                      Text("Notes", style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/settings')
                      .then((value) => setState(() {})),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.all(5)),
                  child: Column(
                    children: [
                      Icon(
                        color: textColor,
                        Icons.settings,
                      ),
                      Text("Settings", style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
