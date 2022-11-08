import 'package:flutter/material.dart';
import 'utils/colors.dart';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  @override
  void initState() {
    setPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Converter",
          style: TextStyle(color: textColor),
        ),
        backgroundColor: buttonColor,
      ),
    );
  }
}
