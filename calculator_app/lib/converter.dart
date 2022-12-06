import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'utils/converter_units.dart';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String displayText = "";
  @override
  void initState() {
    setPrefs();
    super.initState();
  }

  @override
  String myGroupValue = "meter";
  Widget myConvertDialogBuilder({String type = "meter"}) {
    myGroupValue = "Tera";
    return StatefulBuilder(
      builder: ((context, setState) {
        return FractionallySizedBox(
          alignment: Alignment.center,
          heightFactor: 0.5,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                for (MapEntry<String, double> item in metricSystem.entries)
                  RadioListTile(
                    title: Text((item.key == "")
                        ? type[0].toUpperCase() + type.substring(1)
                        : item.key + type),
                    value: item.key,
                    groupValue: myGroupValue,
                    onChanged: (value) {
                      setState(() {
                        myGroupValue = item.key;
                      });
                    },
                  )
              ],
            ),
          ),
        );
      }),
    );
  }

  void onEnter(String inputText) {
    var getUnit = RegExp(r'([a-zA-Z]+)');
    if (!getUnit.hasMatch(inputText)) {
      setState(() {
        displayText = "Invalid Input";
      });
    } else {
      var unitMatch = getUnit.firstMatch(inputText);
      var unit = inputText.substring(unitMatch!.start, unitMatch.end);
      unit.toLowerCase();
      if (meterAliases.contains(unit)) {}
      myShowDialog();
    }
  }

  Widget build(BuildContext context) {
    final myInputController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Converter",
          style: TextStyle(color: textColor),
        ),
        backgroundColor: buttonColor,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                displayText,
              ),
            ),
          ),
          const Spacer(),
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
                      hintText: 'Enter your number and unit',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                    controller: myInputController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => onEnter(myInputController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Icon(Icons.search_rounded, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final ScrollController _scrollController = ScrollController();
  _scrollToRight() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeOut,
    );
  }

  void myShowDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("What would you like to convert to?",
            style: TextStyle(color: textColor, fontSize: 18)),
        content: myConvertDialogBuilder(),
        contentPadding: const EdgeInsets.only(top: 20),
        backgroundColor: buttonColor,
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: textColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Confirm!',
              style: TextStyle(color: textColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
