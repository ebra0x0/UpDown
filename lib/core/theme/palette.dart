import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Palette {
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF96D0FF);
  static const Color lightAccent = Color(0xFFA0D4FF);
  static const Color lightScaffold = Color(0xFFFBFBFB);
  static const Color lightWhite = Color(0xFFFFFFFF);
  static const Color lightBlack = Color(0xFF1D1D1D);
  static const Color lightGrey = Color(0xFFADB5BD);
  static const Color lightYellow = Color(0xFFFFD166);
  static const Color lightGreen = Color(0xFF07CFB1);
  static const Color lightRed = Color(0xFFEF476F);
  static const Color lightBlue = Color(0xFF2F80ED);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF005AA3);
  static const Color darkAccent = Color(0xFF292D3D);
  static const Color darkScaffold = Color(0xff161627);

  static const Color darkBlack = Color(0xFF1D1E33);
  static const Color darkWhite = Color(0xFFFFFFFF);
  static const Color darkGrey = Color(0xFF9A8C98);
  static const Color darkYellow = Color(0xFFFFD166);
  static const Color darkGreen = Color(0xFF07CFB1);
  static const Color darkRed = Color(0xFFEF476F);
  static const Color darkBlue = Color(0xFF2F80ED);

  // Light ThemeData
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightScaffold,
      primaryColor: lightPrimary,
      cardTheme: CardTheme(
        color: lightWhite,
        shadowColor: Color(0xFFE0E0E0),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightScaffold,
        foregroundColor: lightBlack,
        elevation: 0,
      ),
      textTheme: GoogleFonts.notoKufiArabicTextTheme(),
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightAccent,
        surface: lightScaffold,
        error: lightRed,
      ),
    );
  }

  // Dark ThemeData
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkScaffold,
      primaryColor: darkPrimary,
      cardTheme: const CardTheme(
        color: darkBlack,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkScaffold,
        foregroundColor: darkWhite,
        elevation: 0,
      ),
      textTheme: GoogleFonts.notoKufiArabicTextTheme().apply(
        bodyColor: darkWhite,
        displayColor: darkWhite,
      ),
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkAccent,
        surface: darkScaffold,
        error: darkRed,
      ),
    );
  }
}
