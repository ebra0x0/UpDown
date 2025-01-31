import 'package:UpDown/features/create_report/data/model/report_model.dart';
import 'package:UpDown/features/home/data/model/elevator_summary_model.dart';

class BuildingModel {
  final String buildingId;
  final String name;
  final String address;
  final String ownerId;
  final int floorCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ElevatorSummaryModel> elevators;
  final List<ReportModel>? reports;
  final List<ReportModel>? activeReports;

  BuildingModel({
    required this.buildingId,
    required this.name,
    required this.address,
    required this.ownerId,
    required this.floorCount,
    required this.createdAt,
    required this.updatedAt,
    required this.elevators,
    this.reports,
    this.activeReports,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      reports: json['reports'],
      activeReports: json['active_reports'],
      elevators: json['elevators'],
      buildingId: json['building_id'],
      name: json['building_name'],
      address: json['address'],
      ownerId: json['owner_id'],
      floorCount: json['floor_count'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'building_id': buildingId,
      'building_name': name,
      'address': address,
      'owner_id': ownerId,
      'floor_count': floorCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
