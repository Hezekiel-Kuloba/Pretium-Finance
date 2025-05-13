import 'package:pretium_finance/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // Light Theme - Primary color: #025859
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryLight,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSurface: AppColors.onSurface,
    ),
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: AppColors.dividerColor,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.cabin(
        color: AppColors.primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      elevation: 0,
      centerTitle: true,
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.onPrimary,
        backgroundColor: AppColors.primaryColor,
        textStyle: GoogleFonts.cabin(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 3,
        shadowColor: AppColors.primaryLight,
        minimumSize: const Size(double.infinity, 60),
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: GoogleFonts.cabin(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.surface,
      shadowColor: AppColors.primaryLight.withOpacity(0.2),
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // ListTile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      iconColor: AppColors.primaryColor,
      textColor: AppColors.primaryColor,
      tileColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // BottomNavigationBar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.grey,
      elevation: 0,
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.cabin(
        color: AppColors.primaryColor,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.cabin(
        color: AppColors.primaryColor,
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.cabin(
        color: AppColors.primaryColor,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.cabin(color: AppColors.onSurface, fontSize: 16.0),
      bodyMedium: GoogleFonts.cabin(color: AppColors.onSurface, fontSize: 14.0),
      labelLarge: GoogleFonts.cabin(
        color: AppColors.primaryColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      hintStyle: GoogleFonts.cabin(color: AppColors.grey),
      labelStyle: GoogleFonts.cabin(color: AppColors.primaryColor),
      errorStyle: GoogleFonts.cabin(color: AppColors.error),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 2.0),
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: GoogleFonts.cabin(
        color: AppColors.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: GoogleFonts.cabin(
        color: AppColors.onSurface,
        fontSize: 16,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: AppColors.primaryColor, size: 24),
  );

  // Dark Theme - Darker teal variation
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary, // Slightly lighter teal for dark mode
      secondary: AppColors.primaryLight,
      surface: AppColors.darkSurface,
      background: AppColors.darkBackground,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSurface: AppColors.darkOnSurface,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    dividerColor: AppColors.dividerColor.withOpacity(0.1),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.cabin(
        color: AppColors.darkPrimary,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: AppColors.darkPrimary),
      elevation: 0,
      centerTitle: true,
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.onPrimary,
        backgroundColor: AppColors.darkPrimary,
        textStyle: GoogleFonts.cabin(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 3,
        shadowColor: AppColors.primaryLight.withOpacity(0.3),
        minimumSize: const Size(double.infinity, 60),
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        textStyle: GoogleFonts.cabin(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.darkSurface,
      shadowColor: Colors.black.withOpacity(0.5),
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // ListTile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      iconColor: AppColors.darkPrimary,
      textColor: AppColors.darkPrimary,
      tileColor: AppColors.darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // BottomNavigationBar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.darkBackground,
      selectedItemColor: AppColors.darkPrimary,
      unselectedItemColor: AppColors.grey,
      elevation: 0,
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.cabin(
        color: AppColors.darkPrimary,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.cabin(
        color: AppColors.darkPrimary,
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.cabin(
        color: AppColors.darkPrimary,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.cabin(
        color: AppColors.darkOnSurface,
        fontSize: 16.0,
      ),
      bodyMedium: GoogleFonts.cabin(
        color: AppColors.darkOnSurface,
        fontSize: 14.0,
      ),
      labelLarge: GoogleFonts.cabin(
        color: AppColors.darkPrimary,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      hintStyle: GoogleFonts.cabin(color: AppColors.grey),
      labelStyle: GoogleFonts.cabin(color: AppColors.darkPrimary),
      errorStyle: GoogleFonts.cabin(color: AppColors.error),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkPrimary),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkPrimary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkPrimary, width: 2.0),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 2.0),
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: GoogleFonts.cabin(
        color: AppColors.darkPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: GoogleFonts.cabin(
        color: AppColors.darkOnSurface,
        fontSize: 16,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(color: AppColors.darkPrimary, size: 24),
  );
}
