import 'package:flutter/material.dart';
import 'package:calculator_app/navbarItems/settingsNav.dart';

class MyNavbar extends StatelessWidget {
  const MyNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        SettingsNav(),
      ],
    );
  }
}
