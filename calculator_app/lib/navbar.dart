import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyNavbar extends StatelessWidget {
  const MyNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          height: 60,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.calculate),
              label: "Page 1",
            ),
            NavigationDestination(
              icon: Icon(Icons.calculate),
              label: "Page 2",
            ),
          ],
        ),
      ),
    );
  }
}
