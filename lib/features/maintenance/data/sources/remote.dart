import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';

class MaintenanceRemoteDataSource {
  final ApiService _api;

  MaintenanceRemoteDataSource(this._api);

  Stream<MaintenanceModel?> streamActiveMaintenance() {
    return _api.streamActiveMaintenance().map((json) {
      if (json == null) return null;
      return MaintenanceModel.fromJson(json);
    });
  }
}
