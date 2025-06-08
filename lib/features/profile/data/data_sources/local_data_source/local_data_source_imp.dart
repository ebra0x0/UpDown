import 'package:UpDown/core/utils/localization/constants.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/features/profile/data/data_sources/local_data_source/local_data_source.dart';
import 'package:hive/hive.dart';

class ProfileLocalDataSourceImp implements ProfileLocalDataSource {
  late Box<ProfileModel> _profileBox;

  ProfileLocalDataSourceImp() {
    _init();
  }
  void _init() async {
    _profileBox = Hive.box(kProfileBox);
  }

  @override
  Future<ProfileModel?> call() async {
    return _profileBox.get(kUserDataKey);
  }

  @override
  Future<void> save(ProfileModel profile) async {
    await _profileBox.put(kUserDataKey, profile);
  }

  @override
  Future<void> clear() async {
    await _profileBox.delete(kUserDataKey);
  }
}
