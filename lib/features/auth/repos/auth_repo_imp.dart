import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/core/storage/secure/secure_constants.dart';
import 'package:UpDown/core/storage/secure/secure_storage.dart';
import 'package:UpDown/core/utils/model/user_credentials_model.dart';
import 'package:UpDown/features/auth/repos/auth_repo.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImp implements AuthRepo {
  final ApiService _api;

  AuthRepoImp(this._api);

  @override
  Stream<Session?> get sessionMonitor async* {
    yield* _api.onAuthStateChanged.asyncMap((session) async {
      if (session != null && session.isExpired) {
        try {
          // Attempt to refresh the session using the saved refresh token
          String? savedRefToken = await getRefreshToken();

          if (savedRefToken == null) {
            return null; // No refresh token available
          }

          final Session? refreshedSession = await refreshSession(savedRefToken);

          if (refreshedSession != null) {
            setRefreshToken(refreshedSession.refreshToken!);
          }
          return refreshedSession;
        } catch (e) {
          rethrow;
        }
      }
      return session;
    });
  }

  @override
  Future<Session?> refreshSession(String refreshToken) async {
    return await _api
        .refreshToken(refreshToken)
        .fold((_) => null, (session) => session);
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async =>
      await _api.resetPassword(email: email);

  @override
  Future<Either<Failure, Session>> signInWithPassword(
          {required UserCredentialsModel credentials}) async =>
      await _api.signInWithPassword(credentials);

  @override
  Future<Either<Failure, void>> signOut() async => await _api.signOut();

  @override
  Future<String?> getRefreshToken() async =>
      await getIt.get<SecureStorage>().read(SecureConstants.refreshTokenKey);

  @override
  void setRefreshToken(String refreshToken) => getIt
      .get<SecureStorage>()
      .write(SecureConstants.refreshTokenKey, refreshToken);

  @override
  Future<Either<Failure, bool>> isNewAccount() async =>
      await _api.isNewAccount();

  @override
  Future<Either<Failure, Session?>> signUp(
          {required UserCredentialsModel credentials}) async =>
      await _api.signUp(credentials);

  @override
  Future<Either<Failure, void>> sendConfirmationEmail(String email) async =>
      await _api.sendConfirmationEmail(email);
}
