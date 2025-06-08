import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:either_dart/either.dart';

abstract class ProfileRepo {
  Future<ProfileModel?> callLocal();

  Future<Either<Failure, ProfileModel?>> callRemote();

  Future<Either<Failure, void>> update(ProfileModel profile);

  void save(ProfileModel profile);

  void clear();
}
