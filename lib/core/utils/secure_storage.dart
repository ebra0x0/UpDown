import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage(this.storage);
  final FlutterSecureStorage storage;
  void add(String key, String value) => storage.write(key: key, value: value);

  Future<String?> get(String key) => storage.read(key: key);

  void delete(String key) => storage.delete(key: key);

  void deleteAll() => storage.deleteAll();

  void addAll(Map<String, String> map) {
    map.forEach((key, value) => add(key, value));
  }
}
