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
    'pink': Colors.pink,
    'teal': Colors.teal,
    'orange': Colors.orange,
  };

  void _setColor(String colorName, Color color) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferences"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 25),
                child: Text(
                  "Select Preferred Text Color",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                    onPressed: () => _setColor(element.key, element.value),
                  ),
                )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 25),
                child: Text(
                  "Select Preferred Button/Theme Color",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                    onPressed: () => _setColor(element.key, element.value),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}

Color? textColor;
Color? buttonColor;
