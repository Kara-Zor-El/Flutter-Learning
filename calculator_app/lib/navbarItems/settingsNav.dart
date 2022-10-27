import 'package:calculator_app/settings.dart';
import 'package:flutter/material.dart';

class SettingsNav extends StatefulWidget {
  const SettingsNav({super.key});

  @override
  State<SettingsNav> createState() => _SettingsNavState();
}

class _SettingsNavState extends State<SettingsNav> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onClick(context),
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, padding: const EdgeInsets.all(5)),
      child: Column(
        children: [
          Icon(
            color: textColor,
            Icons.settings,
          ),
          Text("Settings", style: TextStyle(color: textColor)),
        ],
      ),
    );
  }

  void onClick(BuildContext context) {
    Navigator.of(context)
        .pushNamed('/settings')
        .then((value) => setState(() {}));
  }
}
