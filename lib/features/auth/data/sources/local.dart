import 'dart:convert';

import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/auth/data/model/auth_response_model.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSource {
  static const _boxName = HiveConstants.authBox;
  static const _authStateKey = HiveConstants.authStateKey;

  Future<LazyBox> _getBox() async {
    try {
      if (!Hive.isBoxOpen(_boxName)) {
        return await Hive.openLazyBox(_boxName);
      }
      return Hive.lazyBox(_boxName);
    } catch (e) {
      throw ('Failed to open auth box: $e');
    }
  }

  Future<AuthResponseModel?> get() async {
    try {
      final box = await _getBox();
      final auth = await box.get(_authStateKey);
      if (auth == null) return null;
      return AuthResponseModel.fromJson(jsonDecode(auth));
    } catch (e) {
      throw ('Failed to get auth state: $e');
    }
  }

  Future<void> save(AuthResponseModel auth) async {
    try {
      final box = await _getBox();
      await box.put(_authStateKey, jsonEncode(auth.toJson()));
    } catch (e) {
      throw ('Failed to save auth state: $e');
    }
  }

  Future<void> clear() async {
    try {
      final box = await _getBox();
      await box.clear();
    } catch (e) {
      throw ('Failed to clear auth state: $e');
    }
  }

  Future<void> closeBox() async {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        final box = Hive.lazyBox(_boxName);
        await box.close();
      }
    } catch (e) {
      throw ('Failed to close auth box: $e');
    }
  }
}
