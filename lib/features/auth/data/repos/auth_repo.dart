import 'dart:developer';
import 'package:UpDown/core/network/api/api_failure.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/auth/data/model/auth_request_model.dart';
import 'package:UpDown/features/auth/data/model/auth_response_model.dart';
import 'package:UpDown/features/auth/data/sources/local.dart';
import 'package:UpDown/features/auth/data/sources/local_user_data.dart';
import 'package:UpDown/features/auth/data/sources/remote.dart';
import 'package:either_dart/either.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepo {
  final AuthLocalDataSource _local;
  final AuthRemoteDataSource _remote;
  final UserDataLocalDataSource _userDataLocal;
  final NetworkManager _netManager;
  bool get isConnected => _netManager.isConnected;

  AuthRepo(this._local, this._remote, this._userDataLocal, this._netManager);

  Stream<AuthResponseModel> getAuthState() async* {
    try {
      final local = await _local.get();
      yield local ??
          AuthResponseModel(
              status: AuthStatus.unAuthenticated, session: null, user: null);

      yield* Rx.merge([
        if (isConnected) _handleConnectionChange(true, local),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) => _handleConnectionChange(true, local))
      ]);
    } on Failure catch (_) {
      yield AuthResponseModel(status: AuthStatus.error);
    } catch (_) {
      yield AuthResponseModel(status: AuthStatus.error);
    }
  }

  Stream<AuthResponseModel> _handleConnectionChange(
      bool isConnected, AuthResponseModel? lastKnown) async* {
    if (!isConnected) return;

    final remoteStream = _remote.getAuthState().handleError((e) {
      Future.delayed(Duration(seconds: 5), () {
        _remote.getAuthState();
      });
    });

    yield* remoteStream.asyncMap((remoteRes) async {
      try {
        await _local.save(remoteRes);
        return remoteRes;
      } catch (e) {
        return remoteRes;
      }
    });
  }

  Future<Either<Failure, AuthResponseModel>> signUp(
      {required AuthRequestModel credentials}) async {
    try {
      final res = await _remote.signUp(credentials: credentials);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure("غير قادر على انشاء الحساب."));
    }
  }

  Future<Either<Failure, AuthResponseModel>> signInWithPassword(
      {required AuthRequestModel credentials}) async {
    try {
      final res = await _remote.signInWithPassword(credentials: credentials);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure("غير قادر على تسجيل الدخول."));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      final res = await _remote.signOut();
      await _local.clear();
      await _userDataLocal.clearAllUserBoxes();
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(CustomFailure("تعذر تسجيل الخروج."));
    }
  }

  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      final res = await _remote.resetPassword(email: email);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(CustomFailure("تعذر اعادة تعيين كلمة المرور."));
    }
  }

  Future<Either<Failure, void>> sendConfirmationEmail(String email) async {
    try {
      final res = await _remote.sendConfirmationEmail(email);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      log(e.toString());
      return Left(CustomFailure("تعذر ارسال رابط التفعيل."));
    }
  }
}
