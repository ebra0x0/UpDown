import 'package:UpDown/features/issues/data/models/report_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/buildings/data/models/floor_model.dart';

class BuildingModel {
  final String id;
  final String name;
  final String address;
  final String ownerId;
  final List<FloorModel> floors;
  final List<FloorModel>? closedFloors;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ElevatorSummaryModel> elevators;
  final List<ReportModel> reports;
  final ReportModel? activeReport;

  BuildingModel({
    required this.id,
    required this.name,
    required this.address,
    required this.ownerId,
    required this.floors,
    this.closedFloors,
    required this.createdAt,
    required this.updatedAt,
    required this.elevators,
    this.reports = const [],
    this.activeReport,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      reports: (json['reports'] as List<dynamic>)
          .map((dynamic r) => ReportModel.fromJson(r as Map<String, dynamic>))
          .toList(),
      activeReport: (json['active_report'] as Map<String, dynamic>?) != null
          ? ReportModel.fromJson(json['active_report'] as Map<String, dynamic>)
          : null,
      elevators: (json['elevators'] as List<dynamic>)
          .map(
            (e) => ElevatorSummaryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      id: json['building_id'],
      name: json['building_name'],
      address: json['address'],
      ownerId: json['owner_id'],
      floors: (json['floors'] as List<dynamic>)
          .map((f) => FloorModel.fromJson(f))
          .toList(),
      closedFloors: (json['closed_floors'] as List<dynamic>)
          .map((cf) => FloorModel.fromJson(cf as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'building_id': id,
      'building_name': name,
      'address': address,
      'owner_id': ownerId,
      'floors': floors,
      'closed_floors': closedFloors,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
