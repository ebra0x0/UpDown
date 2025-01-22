import 'package:UpDown/core/utils/model/issue_model.dart';

class ElevatorModel {
  final String elevatorId;
  final String buildingId;
  final String status;
  final DateTime? lastMaintenanceDate;
  final List<IssueModel> issues;
  final DateTime createdAt;
  final DateTime updatedAt;

  ElevatorModel({
    required this.elevatorId,
    required this.buildingId,
    required this.status,
    required this.lastMaintenanceDate,
    required this.issues,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ElevatorModel.fromJson(Map<String, dynamic> json) {
    return ElevatorModel(
      issues: [],
      elevatorId: json['elevator_id'],
      buildingId: json['building_id'],
      status: json['status'],
      lastMaintenanceDate: json['last_maintenance_date'] != null
          ? DateTime.parse(json['last_maintenance_date'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'elevator_id': elevatorId,
        'building_id': buildingId,
        'status': status,
        'last_maintenance_date': lastMaintenanceDate?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
