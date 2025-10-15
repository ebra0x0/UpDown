import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';

class BuildingsRemoteDataSource {
  final ApiService _api;

  BuildingsRemoteDataSource(this._api);

  Stream<List<BuildingModel>> streamAllBuildings() {
    return _api.streamUserBuildings().map((json) {
      if (json.isEmpty) return [];
      return json.map((b) => BuildingModel.fromJson(b)).toList();
    });
  }
}
