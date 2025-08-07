import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/units/unit_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'engine_model.g.dart';
part 'engine_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.engineModel)
class EngineModel with _$EngineModel implements UnitModel {
  @FreezedUnionValue('Engine')
  const factory EngineModel({
    @HiveField(0) required String id,
    @HiveField(1) required UnitStatus status,
    @HiveField(2) required String model,
    @HiveField(3, defaultValue: UnitType.engine) required UnitType type,
    @HiveField(4) @JsonKey(name: 'elevator_id') required String elevatorId,
    @HiveField(5) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(6) @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @HiveField(7) @JsonKey(name: 'oil_date') required DateTime oilDate,
    @HiveField(8) @JsonKey(name: 'is_oil_good') required bool isOilGood,
    @HiveField(9)
    @JsonKey(name: 'wire_wheel_type')
    required String wireWheelType,
  }) = _EngineModel;

  factory EngineModel.fromJson(Map<String, dynamic> json) =>
      _$EngineModelFromJson(json);

  factory EngineModel.empty() => EngineModel(
        id: '123456',
        status: UnitStatus.active,
        model: '',
        type: UnitType.engine,
        elevatorId: '',
        createdAt: DateTime(2025),
        updatedAt: null,
        oilDate: DateTime(2025),
        isOilGood: true,
        wireWheelType: '25(4)',
      );
}
