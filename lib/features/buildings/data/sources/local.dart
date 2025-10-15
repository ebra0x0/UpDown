import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:hive/hive.dart';

class BuildingsLocalDataSource {
  static const _boxName = HiveConstants.buildingsBox;

  Future<LazyBox> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openLazyBox(_boxName);
    }

    return Hive.lazyBox(_boxName);
  }

  Future<BuildingModel?> get(String buildingId) async {
    final box = await _getBox();

    final buildings = await _getAllBuildings(box);

    return buildings[buildingId];
  }

  Future<List<BuildingModel>> getAll() async {
    final box = await _getBox();

    final buildings = await _getAllBuildings(box);

    return buildings.values.toList();
  }

  Future<void> save(BuildingModel building) async {
    final box = await _getBox();

    final buildings = await _getAllBuildings(box);

    buildings[building.id] = building;

    await box.put(HiveConstants.buildingsKey, buildings);
  }

  Future<void> saveAll(List<BuildingModel> buildingsList) async {
    final box = await _getBox();

    final buildings = {
      for (final b in buildingsList) b.id: b,
    };

    await Future.wait([
      box.put(HiveConstants.buildingsKey, buildings),
      box.put(HiveConstants.lastSyncKey, DateTime.now().toIso8601String()),
    ]);
  }

  Future<void> delete(String buildingId) async {
    final box = await _getBox();

    final buildings = await _getAllBuildings(box);

    if (buildings.containsKey(buildingId)) {
      buildings.remove(buildingId);
      await box.put(HiveConstants.buildingsKey, buildings);
    }
  }

  Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }

  Future<void> close() async {
    if (Hive.isBoxOpen(_boxName)) {
      final box = Hive.lazyBox<BuildingModel>(_boxName);
      await box.close();
    }
  }

  // Helper function
  Future<Map<String, BuildingModel>> _getAllBuildings(LazyBox box) async {
    final data = await box.get(HiveConstants.buildingsKey) as Map?;
    return (data ?? {}).cast<String, BuildingModel>();
  }
}
