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

  static ThemeData get themeData {
    return _isDark ? AppColors.darkTheme : AppColors.lightTheme;
  }

  static Color get primary =>
      _isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
  static Color get scaffold =>
      _isDark ? AppColors.darkScaffold : AppColors.lightScaffold;
  static Color get background =>
      _isDark ? AppColors.darkBackground : AppColors.lightBackground;
  static Color get surface =>
      _isDark ? AppColors.darkSurface : AppColors.lightSurface;
  static Color get text => _isDark ? AppColors.darkWhite : AppColors.lightBlack;
  static Color get white =>
      _isDark ? AppColors.darkWhite : AppColors.lightWhite;
  static Color get black =>
      _isDark ? AppColors.darkBlack : AppColors.lightBlack;
  static Color get tabBar =>
      _isDark ? AppColors.darkBlack : AppColors.lightWhite;
  static Color get tabBarItem =>
      _isDark ? AppColors.darkWhite : AppColors.lightGrey;
  static Color get shadow =>
      _isDark ? AppColors.darkBlack : AppColors.lightGrey;
  static Color get red => _isDark ? AppColors.darkRed : AppColors.lightRed;
  static Color get green =>
      _isDark ? AppColors.darkGreen : AppColors.lightGreen;
  static Color get blue => _isDark ? AppColors.darkBlue : AppColors.lightBlue;
  static Color get grey => _isDark ? AppColors.darkGrey : AppColors.lightGrey;
  static Color get yellow =>
      _isDark ? AppColors.darkYellow : AppColors.lightYellow;
}
