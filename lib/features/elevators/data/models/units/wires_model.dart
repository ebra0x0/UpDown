import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/units/unit_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'wires_model.g.dart';
part 'wires_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.wiresModel)
class WiresModel with _$WiresModel implements UnitModel {
  @FreezedUnionValue('Wires')
  const factory WiresModel({
    @HiveField(0) required String id,
    @HiveField(1) required UnitStatus status,
    @HiveField(2) required String model,
    @HiveField(3, defaultValue: UnitType.wires) required UnitType type,
    @HiveField(4) @JsonKey(name: 'elevator_id') required String elevatorId,
    @HiveField(5) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(6) @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @HiveField(7) required int count,
    @HiveField(8) required int lenght,
  }) = _WiresModel;

  factory WiresModel.fromJson(Map<String, dynamic> json) =>
      _$WiresModelFromJson(json);

  factory WiresModel.empty() => WiresModel(
      id: '123456',
      status: UnitStatus.active,
      model: '',
      type: UnitType.wires,
      elevatorId: '',
      createdAt: DateTime(2025),
      count: 3,
      lenght: 30);
}
