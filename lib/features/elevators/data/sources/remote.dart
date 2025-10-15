import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';

class ElevatorsRemoteDataSource {
  final ApiService _api;
  ElevatorsRemoteDataSource(this._api);

  Stream<List<ElevatorModel>> streamAllElevators() {
    return _api.streamAllElevators().map((json) {
      if (json.isEmpty) return [];
      return json.map((map) => ElevatorModel.fromJson(map)).toList();
    });
  }
}
