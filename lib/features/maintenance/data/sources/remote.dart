import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';

class MaintenanceRemoteDataSource {
  final ApiService _api;

  MaintenanceRemoteDataSource(this._api);

  Stream<MaintenanceModel?> streamCurrentMaintenance() {
    return _api.streamCurrentMaintenance().map((json) {
      if (json == null) return null;
      return MaintenanceModel.fromJson(json);
    });
  }

  Future<List<MaintenanceModel>> fetchAllMaintenances() async {
    final jsonList = await _api.fetchAllMaintenances();
    return jsonList.map((json) => MaintenanceModel.fromJson(json)).toList();
  }
}
