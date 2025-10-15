import 'package:UpDown/core/network/api/api_failure/api_failures.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:UpDown/features/profile/data/sources/local.dart';
import 'package:UpDown/features/profile/data/sources/remote.dart';
import 'package:either_dart/either.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepo {
  final ProfileLocalDataSource _localDataSource;
  final ProfileRemoteDataSource _remoteDataSource;
  final NetworkManager _netManager;
  bool get isConnected => _netManager.isConnected;

  ProfileRepo(
    this._localDataSource,
    this._remoteDataSource,
    this._netManager,
  );

  Stream<Either<Failure, ProfileResponseModel?>> call() async* {
    try {
      final ProfileResponseModel? local = await _localDataSource.get();

      if (local != null) {
        yield Right(local);
      }

      yield* Rx.merge([
        if (isConnected) _handleConnectionChange(true, local),
        _netManager.connectionStream
            .distinct()
            .where((connected) => connected)
            .asyncExpand((_) => _handleConnectionChange(true, local))
      ]);
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure("تعذر تحميل الملف الشخصي."));
    }
  }

  Stream<Either<Failure, ProfileResponseModel?>> _handleConnectionChange(
      bool isConnected, ProfileResponseModel? localProfile) async* {
    if (!isConnected) return;

    final remoteStream = _remoteDataSource.get().handleError((error) {
      if (error is RealtimeSubscribeException) {
        Future.delayed(Duration(seconds: 5), () {
          _remoteDataSource.get();
        });
      }
    });
    yield* remoteStream.asyncMap((remoteRes) async {
      try {
        if (remoteRes == null) {
          await _localDataSource.clear();
          return const Right(null);
        }

        if (remoteRes != localProfile) {
          await _localDataSource.save(remoteRes);
        }

        return Right(remoteRes);
      } catch (e) {
        return Right(remoteRes);
      }
    });
  }

  Future<Either<Failure, void>> update(ProfileRequestModel profile) async {
    try {
      await _remoteDataSource.update(profile);

      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure("تعذر تحديث الملف الشخصي."));
    }
  }
}
