import 'package:UpDown/features/elevators/data/models/units/unit_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/enums/enums.dart';

part 'elevator_model.freezed.dart';
part 'elevator_model.g.dart';

@freezed
@HiveType(typeId: HiveTypeIds.elevatorModel)
class ElevatorModel with _$ElevatorModel {
  const factory ElevatorModel({
    @HiveField(0) required String id,
    @HiveField(1) @JsonKey(name: 'user_id') required String userId,
    @HiveField(2) @JsonKey(name: 'building_id') required String buildingId,
    @HiveField(3) required String name,
    @HiveField(4) required ElevatorStatus status,
    @HiveField(5)
    @JsonKey(name: 'last_maintenance_date')
    DateTime? lastMaintenanceDate,
    @HiveField(6)
    @JsonKey(name: 'next_maintenance_date')
    DateTime? nextMaintenanceDate,
    @HiveField(7) required int capacity,
    @HiveField(8)
    @JsonKey(name: 'floors_served')
    required List<int> floorsServed,
    @HiveField(9) required List<UnitModel> units,
    @HiveField(10) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(11) @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ElevatorModel;

  factory ElevatorModel.fromJson(Map<String, dynamic> json) =>
      _$ElevatorModelFromJson(json);

  factory ElevatorModel.empty() => ElevatorModel(
        id: '1234567',
        userId: '0',
        buildingId: '0',
        name: 'اسم المصعد',
        status: ElevatorStatus.working,
        lastMaintenanceDate: null,
        nextMaintenanceDate: null,
        capacity: 2,
        floorsServed: <int>[],
        units: <UnitModel>[],
        createdAt: DateTime(2025, 1, 1),
      );
}
