import 'package:UpDown/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeMode _theme = ThemeMode.system;
  static Brightness _brightness = Brightness.light;

  static void setTheme({required ThemeMode mode, required Brightness bright}) {
    _theme = mode;
    _brightness = bright;
  }

  static bool get _isDark {
    if (_theme == ThemeMode.system) {
      return _brightness == Brightness.dark;
    }
    return _theme == ThemeMode.dark;
  }

  static ThemeData get lightTheme => AppColors.lightTheme;
  static ThemeData get darkTheme => AppColors.darkTheme;

  static Color get primaryColor =>
      _isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

  static Color get scaffoldColor =>
      _isDark ? AppColors.darkScaffold : AppColors.lightScaffold;

  static Color get backgroundColor =>
      _isDark ? AppColors.darkBackground : AppColors.lightBackground;

  static Color get surfaceColor =>
      _isDark ? AppColors.darkSurface : AppColors.lightSurface;

  static Color get textColor =>
      _isDark ? AppColors.darkWhite : AppColors.lightBlack;

  static Color get whiteColor =>
      _isDark ? AppColors.darkWhite : AppColors.lightWhite;

  static Color get blackColor =>
      _isDark ? AppColors.darkBlack : AppColors.lightBlack;

  static Color get tabBarColor =>
      _isDark ? AppColors.darkScaffold : AppColors.lightScaffold;

  static Color get tabBarItemColor =>
      _isDark ? AppColors.darkWhite : AppColors.lightGrey;

  static Color get shadowColor =>
      _isDark ? AppColors.darkBlack : AppColors.lightGrey;

  static Color get redColor => _isDark ? AppColors.darkRed : AppColors.lightRed;

  static Color get greenColor =>
      _isDark ? AppColors.darkGreen : AppColors.lightGreen;

  static Color get blueColor =>
      _isDark ? AppColors.darkBlue : AppColors.lightBlue;

  static Color get greyColor =>
      _isDark ? AppColors.darkGrey : AppColors.lightGrey;

  static Color get yellowColor =>
      _isDark ? AppColors.darkYellow : AppColors.lightYellow;

  static Color get overlayColor =>
      _isDark ? AppColors.darkOverlay : AppColors.lightOverlay;
}
