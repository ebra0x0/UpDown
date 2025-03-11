import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:intl/intl.dart';

class ElevatorModel {
  final String elevatorId;
  final String buildingId;
  final int elevatorNumber;
  final String status;
  final DateTime? lastMaintenanceDate;
  final DateTime? nextMaintenanceDate;
  final int maxLoad;
  final List<IssueModel> issues;
  final IssueModel? activeIssue;
  final DateTime createdAt;
  final DateTime updatedAt;

  ElevatorModel({
    required this.elevatorId,
    required this.buildingId,
    required this.elevatorNumber,
    required this.status,
    required this.lastMaintenanceDate,
    required this.nextMaintenanceDate,
    required this.maxLoad,
    this.issues = const [],
    this.activeIssue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ElevatorModel.fromJson(Map<String, dynamic> json) {
    return ElevatorModel(
      elevatorId: json['elevator_id'],
      buildingId: json['building_id'],
      elevatorNumber: json['elevator_number'],
      maxLoad: json['max_load'],
      issues: (json['issues'] as List<dynamic>?)
              ?.map((i) => IssueModel.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      activeIssue: json['active_issue'] != null
          ? IssueModel.fromJson(json['active_issue'])
          : null,
      status: json['status'],
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'elevator_id': elevatorId,
        'building_id': buildingId,
        'elevator_number': elevatorNumber,
        'max_load': maxLoad,
        'status': status,
        'last_maintenance_date': lastMaintenanceDate?.toIso8601String(),
        'next_maintenance_date': nextMaintenanceDate?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
