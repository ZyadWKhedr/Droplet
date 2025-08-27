import 'package:flutter/material.dart';
import 'package:droplet/core/constatnts/app_colors.dart';

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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.darkPrimary.withOpacity(0.6),
    ),
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.darkPrimary,
      displayColor: AppColors.darkPrimary,
    ),
    bottomAppBarTheme: BottomAppBarThemeData(color: Colors.white),
  );
}

ThemeData buildDarkTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF0E0F12),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.white.withOpacity(0.6),
    ),
    textTheme: base.textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    bottomAppBarTheme: BottomAppBarThemeData(color: const Color(0xFF0E0F12)),
  );
}
