import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int finalScore;
  Result(this.finalScore);

  String get resultPhrase {
    var resultText = '';
    if (finalScore <= 4) {
      resultText = 'You\'re pretty standard';
    } else if (finalScore < 8) {
      resultText = 'You\'re kinda... distinctive. But also kinda rad bruv.';
    } else {
      resultText = 'You\'re a fricking monster!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        child: Text(
          resultPhrase,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100));
  }
}
