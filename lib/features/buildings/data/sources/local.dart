import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:hive/hive.dart';

class BuildingsLocalDataSource {
  late LazyBox _buildingsBox;

  BuildingsLocalDataSource() {
    _init();
  }

  void _init() {
    _buildingsBox = Hive.lazyBox<BuildingModel>(HiveConstants.buildingsBox);
  }

  Future<BuildingModel?> get(String buildingId) async {
    return await _buildingsBox.get(buildingId);
  }

  Future<List<BuildingModel>> getAll() async {
    final futures =
        _buildingsBox.keys.map((k) => _buildingsBox.get(k)).toList();
    final buildings = await Future.wait(futures);
    return buildings.cast<BuildingModel>();
  }

  Future<void> save(BuildingModel building) async {
    await _buildingsBox.put(building.id, building);
  }

  Future<void> saveAll(List<BuildingModel> buildings) async {
    await Future.wait(
      buildings.map((building) => _buildingsBox.put(building.id, building)),
    );
  }

  Future<void> clear() async {
    await _buildingsBox.clear();
  }
}
