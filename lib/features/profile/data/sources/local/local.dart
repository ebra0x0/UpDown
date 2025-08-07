import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:hive/hive.dart';

class ProfileLocalDataSource {
  static const _boxName = HiveConstants.profileBox;
  static const _profileKey = HiveConstants.profileKey;

  Future<LazyBox<ProfileResponseModel>> _getBox() async {
    try {
      if (!Hive.isBoxOpen(_boxName)) {
        return await Hive.openLazyBox<ProfileResponseModel>(_boxName);
      }
      return Hive.lazyBox<ProfileResponseModel>(_boxName);
    } catch (e) {
      throw ('Failed to open profile box: $e');
    }
  }

  Future<ProfileResponseModel?> get() async {
    try {
      final box = await _getBox();
      return await box.get(_profileKey);
    } catch (e) {
      throw ('Failed to get profile: $e');
    }
  }

  Future<void> save(ProfileResponseModel profile) async {
    try {
      final box = await _getBox();
      await box.put(_profileKey, profile);
    } catch (e) {
      throw ('Failed to save profile: $e');
    }
  }

  Future<void> clear() async {
    try {
      final box = await _getBox();
      await box.clear();
    } catch (e) {
      throw ('Failed to clear profile: $e');
    }
  }

  Future<void> closeBox() async {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        final box = Hive.lazyBox<ProfileResponseModel>(_boxName);
        await box.close();
      }
    } catch (e) {
      throw ('Failed to close profile box: $e');
    }
  }
}
