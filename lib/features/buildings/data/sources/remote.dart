import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';

class BuildingsRemoteDataSource {
  final ApiService _api;

  BuildingsRemoteDataSource(this._api);

  Stream<BuildingModel?> get(String buildingId) {
    return _api.streamBuildingDetails(buildingId: buildingId).map((json) {
      if (json == null) return null;
      return BuildingModel.fromJson(json);
    });
  }

  Stream<List<BuildingModel>> getAll() {
    return _api.streamUserBuildings().map((json) {
      if (json.isEmpty) return [];
      return json.map((b) => BuildingModel.fromJson(b)).toList();
    });
  }
}
