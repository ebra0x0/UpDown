import 'package:UpDown/core/storage/secure/secure_constants.dart';
import 'package:UpDown/core/storage/secure/secure_storage.dart';

class TokenRepository {
  final SecureStorage _storage;

  TokenRepository(this._storage);

  Future<void> setTokens({
    required String accessToken,
    required String? refreshToken,
  }) async {
    try {
      await Future.wait([
        _storage.write(
          SecureConstants.accessTokenKey,
          accessToken,
        ),
        _storage.write(
          SecureConstants.refreshTokenKey,
          refreshToken,
        ),
      ]);
    } catch (e) {
      throw StorageException('Failed to save tokens: $e');
    }
  }

  Future<String?> getAccessToken() async {
    try {
      final token = await _storage.read(SecureConstants.accessTokenKey);
      return token;
    } catch (e) {
      throw StorageException('Failed to retrieve access token');
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      final token = await _storage.read(SecureConstants.refreshTokenKey);
      return token;
    } catch (e) {
      throw StorageException('Failed to retrieve refresh token');
    }
  }

  Future<void> clearTokens() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw StorageException('Failed to clear tokens');
    }
  }
}
