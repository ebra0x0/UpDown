import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/auth/data/model/auth_request_model.dart';
import 'package:UpDown/features/auth/data/model/auth_response_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final ApiService _api;

  AuthRemoteDataSource(this._api);

  Stream<AuthResponseModel> getAuthState() {
    return _api.authStateStream().asyncMap((authStateRes) async {
      AuthResponseModel updatedRes = authStateRes;

      // No Session
      if (authStateRes.session == null) {
        return updatedRes.copyWith(status: AuthStatus.unAuthenticated);
      }

      // Session Expired
      if (updatedRes.session!.isExpired) {
        final Session? refreshedSession =
            await refreshSession(updatedRes.session!.refreshToken!);

        if (refreshedSession == null) {
          return updatedRes.copyWith(
            status: AuthStatus.unAuthenticated,
            session: null,
            user: null,
          );
        }

        updatedRes = updatedRes.copyWith(
            session: refreshedSession, user: refreshedSession.user);
      }

      // Email Not Confirmed
      if (updatedRes.user?.emailConfirmedAt == null) {
        return updatedRes.copyWith(status: AuthStatus.unconfirmed);
      }

      // Check if the user has a database entry.
      final isNewRes = await isNewAccount();
      if (isNewRes) {
        return updatedRes.copyWith(status: AuthStatus.firstTime);
      }

      return updatedRes.copyWith(status: AuthStatus.authenticated);
    });
  }

  Future<AuthResponseModel> signUp(
          {required AuthRequestModel credentials}) async =>
      await _api.signUp(credentials);

  Future<AuthResponseModel> signInWithPassword(
          {required AuthRequestModel credentials}) async =>
      await _api.signInWithPassword(credentials);

  Future<void> signOut() async => await _api.signOut();

  Future<Session?> refreshSession(String refreshToken) async =>
      await _api.refreshSession(refreshToken);

  Future<void> resetPassword({required String email}) async =>
      await _api.resetPassword(email: email);

  Future<void> sendConfirmationEmail(String email) async =>
      await _api.sendConfirmationEmail(email);

  Future<bool> isNewAccount() async => await _api.isNewAccount();
}
