import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel?>> call();

  Future<Either<Failure, void>> updateAvatar(XFile file);
}
