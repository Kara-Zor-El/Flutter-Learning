import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, Color> colors = {
  'pink': Colors.pink,
  'red': Colors.red,
  'orange': Colors.orange,
  'yellow': Colors.yellow,
  'blue': Colors.blue,
  'green': Colors.green,
  'brown': Colors.brown,
  'white': Colors.white,
};

Color? textColor;
Color? buttonColor;
bool? trollMode = false;
void setPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  textColor = colors[prefs.getString('textColor')];
  buttonColor = colors[prefs.getString('buttonColor')];
  trollMode = prefs.getBool('trollMode');
  buttonColor ??= Colors.brown;
  textColor ??= Colors.white;
  trollMode ??= false;
}
