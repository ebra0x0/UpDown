import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/features/elevators/data/models/elevator_unit_model.dart';

class EngineModel extends ElevatorUnitModel {
  final DateTime lastOiledDate;
  final bool isOilGood;
  final bool isFanOn;

  EngineModel({
    required super.id,
    required super.status,
    required super.model,
    required super.name,
    required super.elevatorId,
    required super.createdAt,
    required super.updatedAt,
    required this.isFanOn,
    required this.isOilGood,
    required this.lastOiledDate,
  });

  factory EngineModel.fromJson(Map<String, dynamic> json) {
    return EngineModel(
      id: json['id'],
      status: UnitStatusExtension.fromString(json['status']),
      model: json['model'],
      name: json['name'],
      elevatorId: json['elevator_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isFanOn: json['details']['is_fan_on'],
      isOilGood: json['details']['oil']['is_good'],
      lastOiledDate: DateTime.parse(json['details']['oil']['last_oiled_date']),
    );
  }
}
