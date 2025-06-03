import 'package:UpDown/core/theme/palette.dart';
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
    return _isDark ? Palette.darkTheme : Palette.lightTheme;
  }

  static Color get primary =>
      _isDark ? Palette.darkPrimary : Palette.lightPrimary;
  static Color get scaffold =>
      _isDark ? Palette.darkScaffold : Palette.lightScaffold;
  static Color get background =>
      _isDark ? Palette.darkBackground : Palette.lightBackground;
  static Color get surface =>
      _isDark ? Palette.darkSurface : Palette.lightSurface;
  static Color get text => _isDark ? Palette.darkWhite : Palette.lightBlack;
  static Color get white => _isDark ? Palette.darkWhite : Palette.lightWhite;
  static Color get tabBar =>
      _isDark ? Palette.darkBlack : Palette.lightScaffold;
  static Color get tabBarItem =>
      _isDark ? Palette.darkWhite : Palette.lightBlack;
  static Color get red => _isDark ? Palette.darkRed : Palette.lightRed;
  static Color get green => _isDark ? Palette.darkGreen : Palette.lightGreen;
  static Color get blue => _isDark ? Palette.darkBlue : Palette.lightBlue;
  static Color get grey => _isDark ? Palette.darkGrey : Palette.lightGrey;
  static Color get yellow => _isDark ? Palette.darkYellow : Palette.lightYellow;
}
