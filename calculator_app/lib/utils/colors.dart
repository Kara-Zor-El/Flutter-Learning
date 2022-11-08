import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, Color> colors = {
  'purple': Colors.purple,
  'red': Colors.red,
  'cyan': Colors.cyan,
  'white': Colors.white,
  'brown': Colors.brown,
  'teal': Colors.teal,
  'orange': Colors.orange,
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
