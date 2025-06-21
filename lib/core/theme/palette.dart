import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Palette {
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF7C83FF);
  static const Color lightScaffold = Color(0xFFF3F4F6);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF4F9FD);
  static const Color lightGrey = Color(0xFF9C9C9C);
  static const Color lightWhite = Color(0xFFFFFFFF);
  static const Color lightBlack = Color(0xFF000000);
  static const Color lightYellow = Color(0xFFFFD166);
  static const Color lightGreen = Color(0xFF07CFB1);
  static const Color lightRed = Color(0xFFEF476F);
  static const Color lightBlue = Color(0xFF2F80ED);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF8e6ff7);
  static const Color darkScaffold = Color(0xFF03101A);
  static const Color darkBackground = Color(0xFF1D1E33);
  static const Color darkSurface = Color(0xFF292D3D);
  static const Color darkGrey = Color(0xFF777777);
  static const Color darkWhite = Color(0xFFFFFFFF);
  static const Color darkBlack = Color(0xFF000000);
  static const Color darkYellow = Color(0xFFFFD166);
  static const Color darkGreen = Color(0xFF029B84);
  static const Color darkRed = Color(0xFFEF476F);
  static const Color darkBlue = Color(0xFF2F80ED);

  // Light ThemeData
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightScaffold,
      primaryColor: lightPrimary,
      cardTheme: const CardThemeData(
        color: lightBackground,
        shadowColor: Color(0xFFE0E0E0),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightScaffold,
        elevation: 0,
      ),
      textTheme: GoogleFonts.notoKufiArabicTextTheme(),
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightSurface,
        surface: lightScaffold,
        error: lightRed,
      ),
      splashColor: lightBackground,
      highlightColor: lightBackground,
    );
  }

  // Dark ThemeData
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkScaffold,
      primaryColor: darkPrimary,
      cardTheme: const CardThemeData(
        color: darkBackground,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkScaffold,
        elevation: 0,
      ),
      textTheme: GoogleFonts.notoKufiArabicTextTheme().apply(
        bodyColor: darkWhite,
        displayColor: darkWhite,
      ),
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkBackground,
        surface: darkScaffold,
        error: darkRed,
      ),
      splashColor: darkBackground,
      highlightColor: darkBackground,
    );
  }
}
