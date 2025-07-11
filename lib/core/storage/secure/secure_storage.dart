abstract class SecureStorage {
  Future<void> write(String key, String? value);
  Future<String?> read(String key);
  Future<void> deleteAll();
}

class StorageException implements Exception {
  final String message;

  StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}
