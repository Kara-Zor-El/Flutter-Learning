import 'package:calculator_app/settings.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(color: textColor),
        ),
        backgroundColor: buttonColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(),
                  hintText: 'Enter a note',
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
