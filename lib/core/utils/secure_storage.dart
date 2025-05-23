import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;
  SecureStorage(this._storage);

  void add(String key, String value) => _storage.write(key: key, value: value);

  Future<String?> get(String key) => _storage.read(key: key);

  void delete(String key) => _storage.delete(key: key);

  void deleteAll() => _storage.deleteAll();

  void addAll(Map<String, String> map) {
    map.forEach((key, value) => add(key, value));
  }
}
