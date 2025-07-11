import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:UpDown/features/profile/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:either_dart/either.dart';

class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  final ApiService _apiService;

  ProfileRemoteDataSourceImp(this._apiService);
  @override
  Future<Either<Failure, ProfileResponseModel?>> call() async =>
      await _apiService.fetchProfile();

  @override
  Future<Either<Failure, ProfileResponseModel>> update(
          ProfileRequestModel profile) async =>
      await _apiService.updateProfile(profile);
}
