import 'dart:convert';

import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/auth/data/model/auth_response_model.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSource {
  late LazyBox _authBox;

  AuthLocalDataSource() {
    _init();
  }

  void _init() {
    _authBox = Hive.lazyBox(HiveConstants.authBox);
  }

  Future<AuthResponseModel?> get() async {
    final auth = await _authBox.get(HiveConstants.authStateKey) as String?;
    if (auth == null) return null;
    return AuthResponseModel.fromJson(jsonDecode(auth));
  }

  Future<void> save(AuthResponseModel auth) async =>
      await _authBox.put(HiveConstants.authStateKey, jsonEncode(auth.toJson()));

  Future<void> clear() async => await _authBox.clear();
}
