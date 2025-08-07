import 'package:UpDown/features/elevators/data/models/units/unit_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/enums/enums.dart';

part 'cabin_model.g.dart';
part 'cabin_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.cabinModel)
class CabinModel with _$CabinModel implements UnitModel {
  @FreezedUnionValue('Cabin')
  const factory CabinModel({
    @HiveField(0) required String id,
    @HiveField(1) required UnitStatus status,
    @HiveField(2) String? model,
    @HiveField(3, defaultValue: UnitType.cabin) required UnitType type,
    @HiveField(4) @JsonKey(name: 'elevator_id') required String elevatorId,
    @HiveField(5) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(6) @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @HiveField(7) @JsonKey(name: 'has_fan') required bool hasFan,
    @HiveField(8) required int capacity,
    @HiveField(9) required PasswordDeviceModel password,
    @HiveField(10) @JsonKey(name: 'light_count') required int lightCount,
  }) = _CabinModel;

  factory CabinModel.fromJson(Map<String, dynamic> json) =>
      _$CabinModelFromJson(json);

  factory CabinModel.empty() => CabinModel(
        id: '123456',
        status: UnitStatus.active,
        model: '',
        type: UnitType.cabin,
        elevatorId: '',
        createdAt: DateTime(2025),
        updatedAt: null,
        hasFan: false,
        capacity: 2,
        password: PasswordDeviceModel.empty(),
        lightCount: 2,
      );
}

@freezed
@HiveType(typeId: HiveTypeIds.passDeviceModel)
class PasswordDeviceModel with _$PasswordDeviceModel {
  const factory PasswordDeviceModel({
    @HiveField(0) @JsonKey(name: 'pass_key') required String pass,
    @HiveField(1) required String type,
    @HiveField(2) @JsonKey(name: 'is_active') required bool isActive,
  }) = _PasswordDeviceModel;

  factory PasswordDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordDeviceModelFromJson(json);

  factory PasswordDeviceModel.empty() => const PasswordDeviceModel(
        pass: '',
        type: '',
        isActive: false,
      );
}
