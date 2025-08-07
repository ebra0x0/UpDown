import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final _boxName = HiveConstants.settingsBox;
  ThemeCubit() : super(ThemeMode.system) {
    getTheme();
  }

  void getTheme() async {
    final box = await _getBox();

    final String? theme = await box.get(HiveConstants.settingsThemeKey);

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
    final box = await _getBox();
    await box.put(HiveConstants.settingsThemeKey, state.name.toString());

    switch (state) {
      case ThemeMode.system:
        emit(ThemeMode.light);
      case ThemeMode.light:
        emit(ThemeMode.dark);
      case ThemeMode.dark:
        emit(ThemeMode.system);
    }
  }

  Future<LazyBox> _getBox() async {
    try {
      final boxName = HiveConstants.settingsBox;
      if (!Hive.isBoxOpen(boxName)) {
        return await Hive.openLazyBox(boxName);
      }
      return Hive.lazyBox(boxName);
    } catch (e) {
      throw ('Failed to open buildings box: $e');
    }
  }

  Future<void> _closeBox() async {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        final box = Hive.lazyBox(_boxName);
        await box.close();
      }
    } catch (e) {
      throw ('Failed to close profile box: $e');
    }
  }

  @override
  Future<void> close() async {
    await _closeBox();
    super.close();
  }
}
