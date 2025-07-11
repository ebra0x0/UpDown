import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:UpDown/features/profile/data/data_sources/local_data_source/local_data_source.dart';
import 'package:hive/hive.dart';

class ProfileLocalDataSourceImp implements ProfileLocalDataSource {
  late Box<ProfileResponseModel> _profileBox;

  ProfileLocalDataSourceImp() {
    _init();
  }
  void _init() async {
    _profileBox = Hive.box(HiveConstants.profileBox);
  }

  @override
  Future<ProfileResponseModel?> call() async {
    return _profileBox.get(HiveConstants.profileUserDataKey);
  }

  @override
  Future<void> save(ProfileResponseModel profile) async {
    await _profileBox.put(HiveConstants.profileUserDataKey, profile);
  }

  @override
  Future<void> clear() async {
    await _profileBox.delete(HiveConstants.profileUserDataKey);
  }
}
