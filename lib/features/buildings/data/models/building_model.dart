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
    @HiveField(1) required String name,
    @HiveField(2) String? notes,
    @HiveField(3) required int number,
    @HiveField(4) required FloorStatus status,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) DateTime? updatedAt,
    @HiveField(7) @Default([]) List<String> elevators,
    @HiveField(8) @JsonKey(name: 'units_count') @Default(0) int unitsCount,
    @HiveField(9)
    @JsonKey(name: 'units_active_count')
    @Default(0)
    int unitsActiveCount,
    @HiveField(10)
    @JsonKey(name: 'is_accessible')
    @Default(true)
    bool isAccessible,
  }) = _FloorModel;

  factory FloorModel.fromJson(Map<String, dynamic> json) =>
      _$FloorModelFromJson(json);

  factory FloorModel.empty() => FloorModel(
        id: '',
        name: '',
        notes: null,
        number: 0,
        status: FloorStatus.accessible,
        createdAt: DateTime(2020, 1, 1),
        updatedAt: null,
        elevators: const [],
        unitsCount: 0,
        unitsActiveCount: 0,
        isAccessible: true,
      );
}
