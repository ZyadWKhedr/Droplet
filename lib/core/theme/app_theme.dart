import 'package:droplet/core/constatnts/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData buildLightTheme() {
  final base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.darkPrimary,
      elevation: 0,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.darkPrimary,
      displayColor: AppColors.darkPrimary,
    ),
  );
}

ThemeData buildDarkTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkPrimary,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF0E0F12),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0E0F12),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}
