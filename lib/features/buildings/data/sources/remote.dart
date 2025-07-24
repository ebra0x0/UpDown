import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';

class BuildingsRemoteDataSource {
  final ApiService _api;

  BuildingsRemoteDataSource(this._api);

  Stream<BuildingModel?> get(String buildingId) {
    return _api.streamBuildingDetails(buildingId: buildingId).map((json) {
      if (json != null) {
        final model = BuildingModel.fromJson(json);
        return model;
      } else {
        return null;
      }
    });
  }

  Stream<List<BuildingModel>> getAll() {
    return _api.streamUserBuildings().map((event) {
      final buildings = event.map((b) => BuildingModel.fromJson(b)).toList();
      return buildings;
    });
  }
}
