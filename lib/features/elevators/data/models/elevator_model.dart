import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_unit_model.dart';
import 'package:intl/intl.dart';

class ElevatorModel {
  final String id;
  final String buildingId;
  final String name;
  final ElevatorStatus status;
  final DateTime? lastMaintenanceDate;
  final DateTime? nextMaintenanceDate;
  final int maxLoad;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Dependencies
  final List<IssueModel> issues;
  final IssueModel? activeIssue;
  final List<ElevatorUnitModel> units;

  ElevatorModel({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.status,
    required this.lastMaintenanceDate,
    required this.nextMaintenanceDate,
    required this.maxLoad,
    required this.createdAt,
    required this.updatedAt,
    required this.issues,
    required this.activeIssue,
    required this.units,
  });

  factory ElevatorModel.fromJson(Map<String, dynamic> json) {
    return ElevatorModel(
      id: json['elevator_id'],
      buildingId: json['building_id'],
      name: json['elevator_name'],
      maxLoad: json['max_load'],
      units: (json['units'] as List<dynamic>?)
              ?.map((u) => ElevatorUnitModel.fromJson(u))
              .toList() ??
          [],
      issues: (json['issues'] as List<dynamic>?)
              ?.map((i) => IssueModel.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      activeIssue: json['active_issue'] != null
          ? IssueModel.fromJson(json['active_issue'])
          : null,
      status: ElevatorStatusExtension.fromString(json['status']),
      lastMaintenanceDate: json['last_maintenance_date'] != null
          ? DateFormat("yyyy-MM-dd").parse(json['last_maintenance_date'])
          : null,
      nextMaintenanceDate: json['next_maintenance_date'] != null
          ? DateTime.parse(json['next_maintenance_date'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Update Elevator
  Map<String, dynamic> toJson() => <String, dynamic>{
        'elevator_name': name,
      };
}
