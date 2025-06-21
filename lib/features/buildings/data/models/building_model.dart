import 'package:UpDown/features/buildings/data/models/floor_model.dart';

class BuildingModel {
  final String id;
  final String ownerId;
  final String name;
  final String address;
  final int elevatorsCount;
  final int reportsCount;
  final DateTime createdAt;
  final DateTime? updatedAt;

  // Debendincies
  final List<FloorModel> floors;

  BuildingModel({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.address,
    required this.floors,
    required this.createdAt,
    required this.updatedAt,
    required this.elevatorsCount,
    required this.reportsCount,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      id: json['id'],
      ownerId: json['owner_id'],
      name: json['name'],
      address: json['address'],
      floors: (json['floors'] as List<dynamic>)
          .map((f) => FloorModel.fromJson(f))
          .toList(),
      elevatorsCount: json['elevators_count'],
      reportsCount: json['reports_count'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  factory BuildingModel.empty() {
    return BuildingModel(
      id: '',
      ownerId: '',
      name: '',
      address: '',
      floors: [],
      createdAt: DateTime.now(),
      updatedAt: null,
      elevatorsCount: 0,
      reportsCount: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'address': address,
      'floors': floors,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
