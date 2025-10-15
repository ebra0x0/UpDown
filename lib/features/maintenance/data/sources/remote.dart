import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/core/utils/models/technician_model.dart';
import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';
import 'package:UpDown/features/maintenance/data/models/maintenance_view_model.dart';

class MaintenanceRemoteDataSource {
  final ApiService _api;

  MaintenanceRemoteDataSource(this._api);

  Stream<MaintenanceViewModel?> streamCurrentMaintenance() {
    return _api.streamCurrentMaintenance().asyncMap((json) async {
      if (json == null) return null;
      return await _createViewModel(json);
    });
  }

  Future<List<MaintenanceViewModel>> fetchAllMaintenances(
      {int offset = 0, int limit = 5}) async {
    final jsonList = await _api.fetchMaintenances(offset: offset, limit: limit);

    if (jsonList.isEmpty) return [];

    final List<Future<MaintenanceViewModel?>> futures =
        jsonList.map((json) async {
      return await _createViewModel(json);
    }).toList();

    final results = await Future.wait(futures);
    return results.whereType<MaintenanceViewModel>().toList();
  }

  Future<MaintenanceViewModel?> _createViewModel(
      Map<String, dynamic> json) async {
    final maintenanceModel = MaintenanceModel.fromJson(json);
    final technicianResponse =
        await _api.fetchTechnician(maintenanceModel.technicianId);

    if (technicianResponse == null) return null;

    final TechnicianModel technician =
        TechnicianModel.fromJson(technicianResponse);

    return MaintenanceViewModel(
      data: maintenanceModel,
      technician: technician,
    );
  }
}
