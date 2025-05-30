class FloorModel {
  final String floorId;
  final String buildingId;
  final int floorNumber;
  final bool isClosed;
  final DateTime createdAt;
  final DateTime updatedAt;

  FloorModel({
    required this.floorId,
    required this.buildingId,
    required this.floorNumber,
    required this.isClosed,
    required this.createdAt,
    required this.updatedAt,
  });

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

  // factory FloorModel.fromJson(Map<String, dynamic> json) {
  factory FloorModel.fromJson(dynamic json) {
    return FloorModel(
      floorId: json['floor_id'],
      buildingId: json['building_id'],
      floorNumber: json['floor_number'],
      isClosed: json['is_closed'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
