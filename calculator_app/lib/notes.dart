import 'package:calculator_app/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final myInputController = TextEditingController();
  List<String> notes = [];
  @override
  void dispose() {
    myInputController.dispose();
    super.dispose();
  }

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
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: SingleChildScrollView(
                  child: GridView.count(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1,
                    padding: const EdgeInsets.all(15),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: [
                      for (int i = 0; i < notes.length; i++)
                        noteConstructor(text: notes[i])
                    ],
                  ),
                ),
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextField(
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Enter a note',
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      ),
                      controller: myInputController,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => onInputHandler(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    child:
                        const Icon(Icons.edit_note_sharp, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onInputHandler() {
    var text = myInputController.text;
    notes.add(text);
    setState(() {});
    myInputController.clear();
  }

  Widget noteConstructor({String text = ""}) {
    return Container(
      color: buttonColor,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          text,
        ),
      ),
    );
  }
}
