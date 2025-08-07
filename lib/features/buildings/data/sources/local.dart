import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:hive/hive.dart';

class BuildingsLocalDataSource {
  static const _boxName = HiveConstants.buildingsBox;

  Future<LazyBox<BuildingModel>> _getBox() async {
    try {
      if (!Hive.isBoxOpen(_boxName)) {
        return await Hive.openLazyBox<BuildingModel>(_boxName);
      }
      return Hive.lazyBox<BuildingModel>(_boxName);
    } catch (e) {
      throw ('Failed to open buildings box: $e');
    }
  }

  Future<BuildingModel?> get(String buildingId) async {
    try {
      final box = await _getBox();
      return await box.get(buildingId);
    } catch (e) {
      throw ('Failed to get building $buildingId: $e');
    }
  }

  Future<List<BuildingModel>> getAll() async {
    try {
      final box = await _getBox();
      final keys = box.keys.cast<String>();
      final futures = keys.map((key) => box.get(key)).toList();
      final buildings = await Future.wait(futures);
      return buildings.whereType<BuildingModel>().toList();
    } catch (e) {
      throw ('Failed to get all buildings: $e');
    }
  }

  Future<void> save(BuildingModel building) async {
    try {
      final box = await _getBox();
      await box.put(building.id, building);
    } catch (e) {
      throw ('Failed to save building ${building.id}: $e');
    }
  }

  Future<void> saveAll(List<BuildingModel> buildings) async {
    try {
      final box = await _getBox();

      await Future.wait(
        buildings.map((building) => box.put(building.id, building)),
      );
    } catch (e) {
      throw ('Failed to save buildings: $e');
    }
  }

  Future<void> clear() async {
    try {
      final box = await _getBox();
      await box.clear();
    } catch (e) {
      throw ('Failed to clear buildings: $e');
    }
  }

  Future<void> closeBox() async {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        final box = Hive.lazyBox<BuildingModel>(_boxName);
        await box.close();
      }
    } catch (e) {
      throw ('Failed to close buildings box: $e');
    }
  }
}
