import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int finalScore;
  final VoidCallback resetQuiz;

  Result(this.finalScore, this.resetQuiz);

  String get resultPhrase {
    String resultText;
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: resetQuiz,
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
