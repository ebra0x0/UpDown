import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:UpDown/core/storage/hive/hive_type_ids.dart';

part 'building_model.freezed.dart';
part 'building_model.g.dart';

@freezed
@HiveType(typeId: HiveTypeIds.buildingModel)
class BuildingModel with _$BuildingModel {
  const factory BuildingModel({
    @HiveField(0) required String id,
    @HiveField(1) @JsonKey(name: 'owner_id') required String ownerId,
    @HiveField(2) required String name,
    @HiveField(3) required String address,
    @HiveField(4) @JsonKey(name: 'elevators_count') required int elevatorsCount,
    @HiveField(5) @JsonKey(name: 'reports_count') required int reportsCount,
    @HiveField(6) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(7) @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @HiveField(8) required List<FloorModel> floors,
  }) = _BuildingModel;

  factory BuildingModel.fromJson(Map<String, dynamic> json) =>
      _$BuildingModelFromJson(json);

  factory BuildingModel.empty() => BuildingModel(
        id: '12345678',
        ownerId: '',
        name: 'اسم المبنى',
        address: 'عنوان المبنى',
        floors: [],
        createdAt: DateTime(2020, 1, 1),
        updatedAt: null,
        elevatorsCount: 0,
        reportsCount: 0,
      );
}

@freezed
@HiveType(typeId: HiveTypeIds.floorModel)
class FloorModel with _$FloorModel {
  const factory FloorModel({
    @HiveField(0) required String id,
    @HiveField(1) required List<DoorModel> doors,
    @HiveField(2) required int number,
    @HiveField(3) required FloorStatus status,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) required DateTime? updatedAt,
    @HiveField(6) required String buildingId,
  }) = _FloorModel;

  factory FloorModel.fromJson(Map<String, dynamic> json) =>
      _$FloorModelFromJson(json);

  factory FloorModel.empty() => FloorModel(
        id: '12345678',
        doors: const [],
        number: 0,
        status: FloorStatus.accessible,
        createdAt: DateTime(2020, 1, 1),
        updatedAt: null,
        buildingId: '',
      );
}

@freezed
@HiveType(typeId: HiveTypeIds.doorModel)
class DoorModel with _$DoorModel {
  const factory DoorModel({
    @HiveField(0) required String id,
    @HiveField(1) required List<PartModel> parts,
    @HiveField(2) required DoorStatus status,
    @HiveField(3) required String location,
    @HiveField(4) required String elevatorId,
    @HiveField(5) required DateTime installedAt,
  }) = _DoorModel;

  factory DoorModel.fromJson(Map<String, dynamic> json) =>
      _$DoorModelFromJson(json);
}

@freezed
@HiveType(typeId: HiveTypeIds.partModel)
class PartModel with _$PartModel {
  const factory PartModel({
    @HiveField(0) required String id,
    @HiveField(1) required PartType type,
    @HiveField(2) required String model,
    @HiveField(3) String? notes,
    @HiveField(4) required UnitStatus status,
    @HiveField(5) required PartCondition condition,
    @HiveField(6) required DateTime installedAt,
  }) = _PartModel;

  factory PartModel.fromJson(Map<String, dynamic> json) =>
      _$PartModelFromJson(json);
}
