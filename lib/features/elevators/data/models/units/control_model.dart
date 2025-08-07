import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/units/unit_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'control_model.g.dart';
part 'control_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.controlModel)
class ControlModel with _$ControlModel implements UnitModel {
  @FreezedUnionValue('Control')
  const factory ControlModel({
    @HiveField(0) required String id,
    @HiveField(1) required UnitStatus status,
    @HiveField(2) required String model,
    @HiveField(3, defaultValue: UnitType.control) required UnitType type,
    @HiveField(4) @JsonKey(name: 'elevator_id') required String elevatorId,
    @HiveField(5) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(6) @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @HiveField(7) required BoardModel board,
  }) = _ControlModel;

  factory ControlModel.fromJson(Map<String, dynamic> json) =>
      _$ControlModelFromJson(json);

  factory ControlModel.empty() => ControlModel(
        id: '123456',
        status: UnitStatus.active,
        model: '',
        type: UnitType.control,
        elevatorId: '',
        createdAt: DateTime(2025),
        updatedAt: null,
        board: BoardModel.empty(),
      );
}

@freezed
@HiveType(typeId: HiveTypeIds.boardModel)
class BoardModel with _$BoardModel {
  const factory BoardModel({
    @HiveField(0) required String model,
    @HiveField(1) @JsonKey(name: 'stop_code') int? stopCode,
    @HiveField(2) @JsonKey(name: 'is_active') required bool isActive,
  }) = _BoardModel;

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  factory BoardModel.empty() => const BoardModel(
        model: '',
        stopCode: null,
        isActive: false,
      );
}
