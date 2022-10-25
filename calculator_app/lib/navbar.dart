import 'package:calculator_app/settings.dart';
import 'package:flutter/material.dart';

class MyNavbar extends StatelessWidget {
  final int curIndex;
  final ValueChanged<int> onClick;
  const MyNavbar({super.key, required this.curIndex, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: textColor,
          unselectedItemColor: buttonColor,
          currentIndex: curIndex,
          onTap: onClick,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: "Calculator",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
