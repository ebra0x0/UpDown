import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:either_dart/either.dart';

abstract class AccountSetupRepo {
  Future<Either<Failure, void>> setup(ProfileRequestModel profile);
}
