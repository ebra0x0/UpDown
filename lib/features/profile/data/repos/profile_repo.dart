import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:either_dart/either.dart';

abstract class ProfileRepo {
  Future<ProfileResponseModel?> callLocal();

  Future<Either<Failure, ProfileResponseModel?>> callRemote();

  Future<Either<Failure, void>> update(ProfileRequestModel profile);

  Future<void> save(ProfileResponseModel profile);

  Future<void> clear();
}
