import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:UpDown/features/profile/data/sources/local/local.dart';
import 'package:UpDown/features/profile/data/sources/remote/remote.dart';
import 'package:either_dart/either.dart';

class ProfileRepo {
  final ProfileLocalDataSource _localDataSource;
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepo(
    this._localDataSource,
    this._remoteDataSource,
  );

  Stream<Either<Failure, ProfileResponseModel?>> call() async* {
    try {
      // Read data from local first
      final ProfileResponseModel? localProfile = await _localDataSource.get();

      if (localProfile != null) {
        yield Right(localProfile);
      }

      // Read data from remote
      yield* _remoteDataSource.get().asyncMap((remoteRes) async {
        // If remote is null, clear local
        if (remoteRes == null) {
          await _localDataSource.clear();
          return const Right(null);
        }

        // Compare remote with local
        if (remoteRes != localProfile) {
          // Update local
          await _localDataSource.save(remoteRes);
          return Right(remoteRes);
        }
        // If remote is same as local, return local
        return Right(localProfile);
      });
    } on Failure catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Future<Either<Failure, void>> update(ProfileRequestModel profile) async {
    try {
      await _remoteDataSource.update(profile);

      return Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }
}
