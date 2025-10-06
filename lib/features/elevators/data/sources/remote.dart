import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';

class ElevatorsRemoteDataSource {
  final ApiService _api;
  ElevatorsRemoteDataSource(this._api);

  Stream<List<ElevatorModel>> fetchBuildingElevators(String buildingId) {
    return _api.streamBuildingElevators(buildingId).map((json) {
      if (json.isEmpty) return [];
      return json.map((map) => ElevatorModel.fromJson(map)).toList();
    });
  }

  Stream<List<ElevatorModel>> streamBuildingsElevators(
      List<String> buildingIds) {
    return _api.streamBuildingsElevators(buildingIds).map((json) {
      if (json.isEmpty) return [];
      return json.map((map) => ElevatorModel.fromJson(map)).toList();
    });
  }

  Stream<ElevatorModel?> streamElevatorDetails(String elevatorId) {
    return _api.streamElevatorDetails(elevatorId).map((json) {
      if (json == null) return null;
      return ElevatorModel.fromJson(json);
    });
  }

  Stream<List<ElevatorModel>> streamAllElevators() {
    return _api.streamAllElevators().map((json) {
      if (json.isEmpty) return [];
      return json.map((map) => ElevatorModel.fromJson(map)).toList();
    });
  }
}
