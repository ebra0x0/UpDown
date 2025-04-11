import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/auth/data/model/user_credentials_model.dart';
import 'package:UpDown/features/auth/data/repos/auth_repo.dart';
import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImp implements AuthRepo {
  final ApiService _api;

  AuthRepoImp(this._api);
  @override
  Future<Either<Failure, Session?>> refreshToken(String refreshToken) async {
    var session = await _api.refreshToken(refreshToken);

    return session.fold(
      (failure) => Left(failure),
      (session) => Right(session),
    );
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
  Stream<Session?> get sessionMonitor async* {
    yield* _api.onAuthStateChanged.map((event) {
      return event;
    });
  }

  @override
  Future<Either<Failure, Session>> signInWithPassword(
      {required String email, required String password}) async {
    final UserCredentialsModel credentials =
        UserCredentialsModel(email: email, password: password);
    var res = await _api.signInWithPassword(credentials);

    return res.fold(
      (failure) => Left(failure),
      (session) => Right(session),
    );
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
  Future<Either<Failure, Session>> signUp(
      {required String email, required String password}) {
    final UserCredentialsModel credentials =
        UserCredentialsModel(email: email, password: password);
    var res = _api.signUp(credentials);

    return res.fold(
      (failure) => Left(failure),
      (session) => Right(session),
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
}
