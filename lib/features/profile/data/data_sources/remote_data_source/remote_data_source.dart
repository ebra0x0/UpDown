import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:either_dart/either.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Failure, ProfileResponseModel?>> call();
  Future<Either<Failure, ProfileResponseModel>> update(
      ProfileRequestModel profile);
}
