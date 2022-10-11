import 'package:flutter/material.dart';
import 'package:chat_app/constants/constants.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.mantle,
  scaffoldBackgroundColor: AppColors.base,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.overlay0,
    elevation: 0,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.mantle,
  ),
);
