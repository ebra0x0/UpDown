import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  late LazyBox _settingsBox;
  ThemeCubit() : super(ThemeMode.system) {
    getTheme();
  }

  void getTheme() async {
    _settingsBox = Hive.lazyBox(HiveConstants.settingsBox);
    final String? theme =
        await _settingsBox.get(HiveConstants.settingsThemeKey);

    if (theme == null) {
      emit(ThemeMode.system);
      return;
    }

    switch (theme) {
      case 'dark':
        emit(ThemeMode.dark);
      case 'light':
        emit(ThemeMode.light);
      default:
        emit(ThemeMode.system);
    }
  }

  void toggleTheme() async {
    await _settingsBox.put(
        HiveConstants.settingsThemeKey, state.name.toString());

    switch (state) {
      case ThemeMode.system:
        emit(ThemeMode.light);
      case ThemeMode.light:
        emit(ThemeMode.dark);
      case ThemeMode.dark:
        emit(ThemeMode.system);
    }
  }
}
