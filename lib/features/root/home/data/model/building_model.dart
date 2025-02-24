import 'package:UpDown/features/root/create_issue/data/model/report_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/floor_model.dart';

class BuildingModel {
  final String buildingId;
  final String name;
  final String address;
  final String ownerId;
  final List<FloorModel> floors;
  final List<FloorModel> closedFloors;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ElevatorSummaryModel> elevators;
  final List<ReportModel>? reports;
  final ReportModel? activeReport;

  BuildingModel({
    required this.buildingId,
    required this.name,
    required this.address,
    required this.ownerId,
    required this.floors,
    required this.closedFloors,
    required this.createdAt,
    required this.updatedAt,
    required this.elevators,
    this.reports,
    this.activeReport,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      reports: json['reports'],
      activeReport: json['active_report'],
      elevators: json['elevators'],
      buildingId: json['building_id'],
      name: json['building_name'],
      address: json['address'],
      ownerId: json['owner_id'],
      floors: json['floors'],
      closedFloors: json['closed_floors'],
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
      'floors': floors,
      'closed_floors': closedFloors,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
