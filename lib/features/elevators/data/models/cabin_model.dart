import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';

class CabinModel extends UnitModel {
  final String capacity;
  final bool hasBreak;
  final bool hasLights;
  final bool isChearsGood;
  final String passDeviceModel;

  CabinModel({
    required super.id,
    required super.status,
    required super.model,
    required super.name,
    required super.elevatorId,
    required super.createdAt,
    required super.updatedAt,
    required this.capacity,
    required this.hasBreak,
    required this.hasLights,
    required this.isChearsGood,
    required this.passDeviceModel,
  });

  factory CabinModel.fromJson(Map<String, dynamic> json) {
    return CabinModel(
      id: json['id'],
      status: UnitStatusExtension.fromString(json['status']),
      model: json['model'],
      name: json['name'],
      elevatorId: json['elevator_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      capacity: json['details']['capacity'].toString(),
      hasBreak: json['details']['has_break'],
      hasLights: json['details']['has_lights'],
      isChearsGood: json['details']['is_chears_good'],
      passDeviceModel: json['details']['pass_device_model'],
    );
  }
}
