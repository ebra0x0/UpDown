import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final SharedPreferences _storage;
  SharedPref(this._storage);

  void add(String key, String value) => _storage.setString(key, value);

  String? get(String key) => _storage.getString(key);

  Future<bool> remove(String key) => _storage.remove(key);

  Future<bool> clear() => _storage.clear();

  void addAll(Map<String, String> map) {
    map.forEach((key, value) => add(key, value));
  }
}
