import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:either_dart/either.dart';

abstract class AccountSetupRepo {
  Future<Either<Failure, void>> setup(ProfileModel profile);
}
