import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF025859);
  static const Color primaryLight = Color(0xFF038A8C);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color onPrimary = Colors.white;
  static const Color onSurface = Color(0xFF333333);

  // For dark theme
  static const Color darkPrimary = Color(0xFF03A0A3);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnPrimary = Colors.white;
  static const Color darkOnSurface = Colors.white;

  // Other colors
  static const Color grey = Color(0xFF9E9E9E);
  static const Color dividerColor = Color(0xFFEEEEEE);
  static const Color error = Color(0xFFB00020);
}

class AppThemes {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryLight,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSurface: AppColors.onSurface,
    ),
    scaffoldBackgroundColor: AppColors.background,
    // ... rest of your theme configuration
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.primaryLight,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: AppColors.darkOnPrimary,
      onSurface: AppColors.darkOnSurface,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    // ... rest of your theme configuration
  );
}
