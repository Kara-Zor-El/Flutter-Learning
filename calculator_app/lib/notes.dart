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
  final myEditingController = TextEditingController();
  List<String> notes = [];
  @override
  void dispose() {
    myEditingController.dispose();
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
                    crossAxisCount: 3,
                    children: [
                      for (int i = 0; i < notes.length; i++)
                        noteConstructor(text: notes[i], index: i)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: TextField(
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Enter a note',
                          contentPadding: EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                        ),
                        controller: myInputController,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => onInputHandler(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Icon(Icons.edit_note_sharp,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onInputHandler() {
    var text = myInputController.text;
    notes.add(text);
    setState(() {
      notes;
    });
    myInputController.clear();
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    setState(() {
      notes;
    });
  }

  void editNote(String newText, int index) {
    notes[index] = newText;
    setState(() {
      notes;
    });
  }

  Widget noteConstructor({String text = "", required int index}) {
    return Container(
      color: buttonColor,
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.more_horiz_outlined, color: textColor),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Note", style: TextStyle(color: textColor)),
                      content: Text(text, style: TextStyle(color: textColor)),
                      backgroundColor: buttonColor,
                      actions: [
                        TextButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: textColor),
                          ),
                          onPressed: () {
                            deleteNote(index);
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Edit',
                            style: TextStyle(color: textColor),
                          ),
                          onPressed: () {
                            myEditingController.text = text;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  "Edit",
                                  style: TextStyle(color: textColor),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                content: TextField(
                                  maxLines: 5,
                                  style: TextStyle(color: textColor),
                                  decoration: InputDecoration(
                                    fillColor: buttonColor,
                                    filled: true,
                                    hoverColor: buttonColor,
                                    focusColor: buttonColor,
                                    border: InputBorder.none,
                                  ),
                                  controller: myEditingController,
                                ),
                                backgroundColor: buttonColor,
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(color: textColor),
                                    ),
                                    onPressed: () {
                                      editNote(myEditingController.text, index);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: textColor),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: textColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
                padding: const EdgeInsets.all(2),
                splashRadius: 5,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                (text.length > 40) ? "${text.substring(0, 40)}..." : text,
              ),
            ),
          )
        ],
      ),
    );
  }
}
