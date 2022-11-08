import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    trollMode = false;
    setPrefs();
    super.initState();
  }

  void _setButtonColor({String newButtonColor = 'brown'}) async {
    final prefs = await SharedPreferences.getInstance();
    buttonColor = colors[newButtonColor];
    prefs.setString('buttonColor', newButtonColor);
    setState(() {
      buttonColor;
    });
  }

  void _setTextColor({String newTextColor = 'white'}) async {
    final prefs = await SharedPreferences.getInstance();
    textColor = colors[newTextColor];
    prefs.setString('textColor', newTextColor);
    setState(() {
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: [
                for (var element in colors.entries)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: element.value,
                        minimumSize:
                            Size(50, (MediaQuery.of(context).size.height / 8)),
                      ),
                      child: const Text(''),
                      onPressed: () => _setTextColor(newTextColor: element.key),
                    ),
                  )
              ],
            ),
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
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
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
                            _setButtonColor(newButtonColor: element.key),
                      ),
                    )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: trollModeHandler,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              minimumSize: Size(50, (MediaQuery.of(context).size.height / 10)),
            ),
            child: !(trollMode ??= false)
                ? const Text("Enable Troll Mode?")
                : const Text("Disable Troll Mode?"),
          ),
        ],
      ),
    );
  }

  void trollModeHandler() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('trollMode', !(trollMode ??= true));
    trollMode = prefs.getBool('trollMode')!;
    setState(() {});
  }
}
