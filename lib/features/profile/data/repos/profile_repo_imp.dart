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
  Future<ProfileModel?> callLocal() async {
    final ProfileModel? localData = await _localDataSource.call();

    return localData;
  }

  @override
  Future<Either<Failure, ProfileModel?>> callRemote() {
    final res = _remoteDataSource.call();
    return res;
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
