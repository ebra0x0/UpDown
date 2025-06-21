import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';

class ElevatorModel {
  final String id;
  final String buildingId;
  final String name;
  final ElevatorStatus status;
  final DateTime? lastMaintenanceDate;
  final DateTime? nextMaintenanceDate;
  final int capacity;
  final List<int> floorsServed;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ElevatorModel({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.status,
    required this.capacity,
    required this.floorsServed,
    required this.lastMaintenanceDate,
    required this.nextMaintenanceDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ElevatorModel.fromJson(Map<String, dynamic> json) {
    return ElevatorModel(
      id: json['id'],
      buildingId: json['building_id'],
      name: json['name'],
      capacity: json['capacity'],
      status: ElevatorStatusExtension.fromString(json['status']),
      lastMaintenanceDate: json['last_maintenance_date'] != null
          ? DateTime.parse(json['last_maintenance_date'])
          : null,
      floorsServed: (json['floors_served'] as List<dynamic>).cast<int>(),
      nextMaintenanceDate: json['next_maintenance_date'] != null
          ? DateTime.parse(json['next_maintenance_date'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at']),
    );
  }

  // Update Elevator
  Map<String, dynamic> toJson() => <String, dynamic>{
        'elevator_name': name,
      };
}
