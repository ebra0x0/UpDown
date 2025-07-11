import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
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
  Future<ProfileResponseModel?> callLocal() async =>
      await _localDataSource.call();

  @override
  Future<Either<Failure, ProfileResponseModel?>> callRemote() async =>
      await _remoteDataSource.call();

  @override
  Future<Either<Failure, void>> update(ProfileRequestModel profile) async {
    final res = await _remoteDataSource.update(profile);

    if (res.isRight) await save(res.right);
    return res;
  }

  @override
  Future<void> save(ProfileResponseModel profile) async =>
      await _localDataSource.save(profile);

  @override
  Future<void> clear() async => await _localDataSource.clear();
}
