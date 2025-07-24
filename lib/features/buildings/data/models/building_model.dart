import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(createToJson: false)
class BuildingModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  @JsonKey(name: 'owner_id')
  final String ownerId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String address;
  @HiveField(4)
  @JsonKey(name: 'elevators_count')
  final int elevatorsCount;
  @HiveField(5)
  @JsonKey(name: 'reports_count')
  final int reportsCount;
  @HiveField(6)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @HiveField(7)
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  // Debendincies
  @HiveField(8)
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

  factory BuildingModel.fromJson(Map<String, dynamic> json) =>
      _$BuildingModelFromJson(json);

  factory BuildingModel.empty() {
    return BuildingModel(
      id: '',
      ownerId: '',
      name: 'اسم المبنى',
      address: 'عنوان المبنى',
      floors: [],
      createdAt: DateTime.now(),
      updatedAt: null,
      elevatorsCount: 0,
      reportsCount: 0,
    );
  }
}

@HiveType(typeId: 2)
@JsonSerializable(createToJson: false)
class FloorModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  @JsonKey(name: 'building_id')
  final String buildingId;
  @HiveField(2)
  @JsonKey(name: 'floor_number')
  final int floorNumber;
  @HiveField(3)
  @JsonKey(name: 'is_closed')
  final bool isClosed;
  @HiveField(4)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @HiveField(5)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const FloorModel({
    required this.id,
    required this.buildingId,
    required this.floorNumber,
    required this.isClosed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) =>
      _$FloorModelFromJson(json);

  factory FloorModel.empty() {
    return FloorModel(
      id: '12345678',
      buildingId: '',
      floorNumber: 0,
      isClosed: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
