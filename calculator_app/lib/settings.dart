import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Map<String, Color> colors = {
    'purple': Colors.purple,
    'blue': Colors.blue,
    'yellow': Colors.white,
    'pink': Colors.brown,
    'teal': Colors.teal,
    'orange': Colors.orange,
  };

  void _setColor({Color? newTextColor, Color? newButtonColor}) {
    if (newButtonColor == null) {
      textColor = newTextColor;
    } else if (newTextColor == null) {
      buttonColor = newButtonColor;
    }
    setState(() {
      buttonColor;
      textColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Preferences",
            style: TextStyle(color: textColor),
          ),
          backgroundColor: buttonColor,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 25),
                  child: Text(
                    "Select Preferred Text Color",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                for (var element in colors.entries)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: element.value,
                        minimumSize:
                            Size(50, (MediaQuery.of(context).size.height / 8)),
                      ),
                      child: Text(''),
                      onPressed: () => _setColor(newTextColor: element.value),
                    ),
                  )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 25),
                  child: Text(
                    "Select Preferred Theme Color",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                children: [
                  for (var element in colors.entries)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: element.value,
                          minimumSize: Size(
                              50, (MediaQuery.of(context).size.height / 8)),
                        ),
                        child: const Text(''),
                        onPressed: () =>
                            _setColor(newButtonColor: element.value),
                      ),
                    )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: trollModeHandler,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                minimumSize:
                    Size(50, (MediaQuery.of(context).size.height / 10)),
              ),
              child: !trollMode
                  ? const Text("Enable Troll Mode?")
                  : const Text("Disable Troll Mode?"),
            ),
          ],
        ));
  }

  void trollModeHandler() {
    trollMode = !trollMode;
    setState(() {
      trollMode;
    });
  }
}

Color? textColor = Colors.white;
Color? buttonColor = Colors.brown;
bool trollMode = false;
