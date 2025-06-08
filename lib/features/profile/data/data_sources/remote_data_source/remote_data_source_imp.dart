import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/features/profile/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:either_dart/either.dart';

class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  final ApiService _apiService;

  ProfileRemoteDataSourceImp(this._apiService);
  @override
  Future<Either<Failure, ProfileModel?>> call() async {
    final response = await _apiService.fetchProfile();
    if (response.isRight) {
      return Right(response.right);
    }
    return Left(response.left);
  }

  @override
  Future<Either<Failure, void>> update(ProfileModel profile) async {
    return await _apiService.updateProfile(profile);
  }
}
