import 'dart:developer';
import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/auth/data/model/auth_request_model.dart';
import 'package:UpDown/features/auth/data/model/auth_response_model.dart';
import 'package:UpDown/features/auth/data/sources/local.dart';
import 'package:UpDown/features/auth/data/sources/remote.dart';
import 'package:either_dart/either.dart';

class AuthRepo {
  final AuthLocalDataSource _localeDataSource;
  final AuthRemoteDataSource _remoteDataSource;
  final NetworkManager _networkManager;

  AuthRepo(
      this._localeDataSource, this._remoteDataSource, this._networkManager);

  Stream<AuthResponseModel> getAuthState() async* {
    try {
      final localAuth = await _localeDataSource.get();
      yield localAuth ??
          AuthResponseModel(
              status: AuthStatus.unAuthenticated, session: null, user: null);

      yield* _networkManager.connectionStream.asyncExpand(
        (isConnected) => _handleConnectionChange(isConnected, localAuth),
      );
    } on Failure catch (e) {
      log(e.toString());
      yield AuthResponseModel(
          status: AuthStatus.error, session: null, user: null);
    } catch (e) {
      log(e.toString());
      yield AuthResponseModel(
          status: AuthStatus.error, session: null, user: null);
    }
  }

  Stream<AuthResponseModel> _handleConnectionChange(
      bool isConnected, AuthResponseModel? lastKnown) async* {
    if (!isConnected) {
      yield lastKnown ??
          AuthResponseModel(
              status: AuthStatus.unAuthenticated, session: null, user: null);
      return;
    }

    final stream = _remoteDataSource.getAuthState();
    await for (final authState in stream) {
      await _localeDataSource.save(authState);
      yield authState;
    }
  }

  Future<Either<Failure, AuthResponseModel>> signUp(
      {required AuthRequestModel credentials}) async {
    try {
      final res = await _remoteDataSource.signUp(credentials: credentials);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Future<Either<Failure, AuthResponseModel>> signInWithPassword(
      {required AuthRequestModel credentials}) async {
    try {
      final res =
          await _remoteDataSource.signInWithPassword(credentials: credentials);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      final res = await _remoteDataSource.signOut();
      await _localeDataSource.clear();
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      final res = await _remoteDataSource.resetPassword(email: email);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Future<Either<Failure, void>> sendConfirmationEmail(String email) async {
    try {
      final res = await _remoteDataSource.sendConfirmationEmail(email);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }
}
