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

@freezed
@HiveType(typeId: HiveTypeIds.floorModel)
class FloorModel with _$FloorModel {
  const factory FloorModel({
    @HiveField(0) required String id,
    @HiveField(1) @JsonKey(name: 'building_id') required String buildingId,
    @HiveField(2) @JsonKey(name: 'floor_number') required int floorNumber,
    @HiveField(3) @JsonKey(name: 'is_closed') required bool isClosed,
    @HiveField(4) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(5) @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _FloorModel;

  factory FloorModel.fromJson(Map<String, dynamic> json) =>
      _$FloorModelFromJson(json);

  factory FloorModel.empty() => FloorModel(
        id: '12345678',
        buildingId: '',
        floorNumber: 0,
        isClosed: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
