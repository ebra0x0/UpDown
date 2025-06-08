import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/features/profile/data/data_sources/local_data_source/local_data_source.dart';
import 'package:UpDown/features/profile/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo.dart';
import 'package:either_dart/either.dart';

class ProfileRepoImp implements ProfileRepo {
  final ProfileLocalDataSource _localDataSource;
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepoImp(
    this._localDataSource,
    this._remoteDataSource,
  );
  @override
  Future<Either<Failure, ProfileModel?>> call() async {
    final localData = await _localDataSource.call();
    if (localData != null) {
      return Right(localData);
    }
    return await _remoteDataSource.call();
  }

  @override
  Future<Either<Failure, void>> update(ProfileModel profile) async {
    final res = await _remoteDataSource.update(profile);
    res.isRight ? save(profile) : null;
    return res;
  }

  @override
  void save(ProfileModel profile) async {
    await _localDataSource.save(profile);
  }

  @override
  void clear() {
    _localDataSource.clear();
  }
}
