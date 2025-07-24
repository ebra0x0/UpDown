import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:hive/hive.dart';

class ProfileLocalDataSource {
  late LazyBox<ProfileResponseModel> _profileBox;

  ProfileLocalDataSource() {
    _init();
  }
  void _init() {
    _profileBox = Hive.lazyBox<ProfileResponseModel>(HiveConstants.profileBox);
  }

  Future<ProfileResponseModel?> get() async =>
      await _profileBox.get(HiveConstants.profileKey);

  Future<void> save(ProfileResponseModel profile) async =>
      await _profileBox.put(HiveConstants.profileKey, profile);

  Future<void> clear() async => await _profileBox.clear();
}
