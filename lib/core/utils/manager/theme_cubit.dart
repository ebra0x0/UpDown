// theme_cubit.dart
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/core/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void getTheme() {
    final String? theme = gitIt<SharedPref>().get('theme');

    if (theme == null) {
      emit(ThemeMode.dark);
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

  void toggleTheme() {
    gitIt<SharedPref>().add('theme', state.name.toString());

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
