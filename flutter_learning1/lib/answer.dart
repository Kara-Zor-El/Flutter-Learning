import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function onClick;
  final String answerText;
  const Answer(this.onClick, this.answerText, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blueAccent,
        ),
        child: Text(
          answerText,
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => onClick(),
      ),
    );
  }
}
