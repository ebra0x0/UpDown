import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/service_locator.dart';
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
        String? savedRefToken = await getRefreshToken();

        final refreshedSession =
            await refreshSession(refreshToken: savedRefToken);

        if (refreshedSession != null) {
          setRefreshToken(refreshedSession.refreshToken!);
        }
        return refreshedSession;
      }
      return session;
    });
  }

  @override
  Future<Session?> refreshSession({String? refreshToken}) async {
    await _api
        .refreshToken(refreshToken: refreshToken)
        .fold((_) => null, (session) => session);
    return null;
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) {
    var res = _api.resetPassword(email: email);

    return res.fold(
      (failure) => Left(failure),
      (res) => Right(res),
    );
  }

  @override
  Future<Either<Failure, Session>> signInWithPassword(
      {required String email, required String password}) async {
    final UserCredentialsModel credentials =
        UserCredentialsModel(email: email, password: password);

    var session = await _api.signInWithPassword(credentials);

    return session.fold((failure) => Left(failure), (session) {
      gitIt.get<SecureStorage>().addAll({
        "access_token": session.accessToken,
        "refresh_token": session.refreshToken!,
        "user_id": session.user.id,
      });
      return Right(session);
    });
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    var res = await _api.signOut();

    return res.fold(
      (failure) => Left(failure),
      (res) => Right(res),
    );
  }

  @override
  Future<String?> getRefreshToken() async {
    return await gitIt.get<SecureStorage>().get("refresh_token");
  }

  @override
  void setRefreshToken(String refreshToken) {
    gitIt.get<SecureStorage>().add("refresh_token", refreshToken);
  }

  @override
  Future<Either<Failure, bool>> isNewAccount() async {
    final newUser = await _api.isNewAccount();

    return newUser.fold((failure) => Left(failure), (status) => Right(status));
  }

  @override
  Future<Either<Failure, Session?>> signUp(
      {required String email, required String password}) async {
    final UserCredentialsModel credentials =
        UserCredentialsModel(email: email, password: password);
    return await _api.signUp(credentials).fold(
          (failure) => Left(failure),
          (session) => Right(session),
        );
  }

  @override
  Future<Either<Failure, void>> sendConfirmationEmail(String email) async {
    var res = await _api.sendConfirmationEmail(email);
    return res.fold(
      (failure) => Left(failure),
      (res) => Right(res),
    );
  }
}
