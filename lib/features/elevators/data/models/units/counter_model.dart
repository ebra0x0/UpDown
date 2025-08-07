import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/units/unit_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'counter_model.g.dart';
part 'counter_model.freezed.dart';

@freezed
@HiveType(typeId: HiveTypeIds.counterModel)
class CounterModel with _$CounterModel implements UnitModel {
  @FreezedUnionValue('Counter')
  const factory CounterModel({
    @HiveField(0) required String id,
    @HiveField(1) required UnitStatus status,
    @HiveField(2) String? model,
    @HiveField(3, defaultValue: UnitType.counter) required UnitType type,
    @HiveField(4) @JsonKey(name: 'elevator_id') required String elevatorId,
    @HiveField(5) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(6) @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @HiveField(7) required int count,
    @HiveField(8) @JsonKey(name: 'is_chairs_good') required bool isChairsGood,
  }) = _CounterModel;

  factory CounterModel.fromJson(Map<String, dynamic> json) =>
      _$CounterModelFromJson(json);

  factory CounterModel.empty() => CounterModel(
        id: '123456',
        status: UnitStatus.active,
        model: '',
        type: UnitType.counter,
        elevatorId: '',
        createdAt: DateTime(2025),
        count: 6,
        isChairsGood: false,
      );
}
