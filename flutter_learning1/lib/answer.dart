import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function onClick;

  const Answer(this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blueAccent,
        ),
        child: Text(
          'First',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => onClick(),
      ),
    );
  }
}
