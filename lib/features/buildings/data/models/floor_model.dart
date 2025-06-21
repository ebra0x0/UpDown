import 'package:equatable/equatable.dart';

class FloorModel extends Equatable {
  final String floorId;
  final String buildingId;
  final int floorNumber;
  final bool isClosed;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FloorModel({
    required this.floorId,
    required this.buildingId,
    required this.floorNumber,
    required this.isClosed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FloorModel.fromJson(dynamic json) {
    return FloorModel(
      floorId: json['floor_id'],
      buildingId: json['building_id'],
      floorNumber: json['floor_number'],
      isClosed: json['is_closed'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  factory FloorModel.empty() {
    return FloorModel(
      floorId: '',
      buildingId: '',
      floorNumber: 0,
      isClosed: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'floor_id': floorId,
      'building_id': buildingId,
      'floor_number': floorNumber,
      'is_closed': isClosed,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        floorId,
        buildingId,
        floorNumber,
        isClosed,
        createdAt,
        updatedAt,
      ];
}
