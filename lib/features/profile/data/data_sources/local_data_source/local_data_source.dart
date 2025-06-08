import 'package:UpDown/core/utils/model/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileModel?> call();

  Future<void> save(ProfileModel profile);

  Future<void> clear();
}
