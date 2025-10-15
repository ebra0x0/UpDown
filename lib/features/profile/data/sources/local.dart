import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:hive/hive.dart';

class ProfileLocalDataSource {
  static const _boxName = HiveConstants.profileBox;

  Future<LazyBox> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openLazyBox(_boxName);
    }
    return Hive.lazyBox(_boxName);
  }

  Future<ProfileResponseModel?> get() async {
    final box = await _getBox();
    return await box.get(HiveConstants.profileKey) as ProfileResponseModel?;
  }

  Future<void> save(ProfileResponseModel profile) async {
    final box = await _getBox();
    await box.put(HiveConstants.profileKey, profile);
  }

  Future<void> delete() async {
    final box = await _getBox();
    await box.delete(HiveConstants.profileKey);
  }

  Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }

  Future<void> close() async {
    if (Hive.isBoxOpen(_boxName)) {
      final box = Hive.lazyBox<ProfileResponseModel>(_boxName);
      await box.close();
    }
  }
}
