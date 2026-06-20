import 'package:flutter/material.dart';

// تعريف الألوان كما حددتها
class AppColors {
  static const Color primaryPurple = Color(0xFF55256C);
  static const Color lighterPurple = Color(0xFFA078B4);
  static const Color pureWhite = Color(0xFFFFFFFF);
}

// دمجها في الـ Theme الرئيسي
ThemeData myAppTheme = ThemeData(
  primaryColor: AppColors.primaryPurple,
  scaffoldBackgroundColor: AppColors.pureWhite,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryPurple,
    secondary: AppColors.lighterPurple,
    surface: AppColors.pureWhite,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryPurple,
    foregroundColor: AppColors.pureWhite,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.lighterPurple,
  ),
);