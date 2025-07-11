import 'package:UpDown/features/profile/data/model/profile_response_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileResponseModel?> call();

  Future<void> save(ProfileResponseModel profile);

  Future<void> clear();
}
