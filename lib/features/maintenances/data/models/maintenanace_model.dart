import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'maintenanace_model.freezed.dart';
part 'maintenanace_model.g.dart';

@HiveType(typeId: HiveTypeIds.maintenanceModel)
@Freezed(toJson: false)
class MaintenanceModel with _$MaintenanceModel {
  const factory MaintenanceModel({
    @HiveField(0) required String id,
    @HiveField(1) @JsonKey(name: 'user_id') required String userId,
    @HiveField(2) @JsonKey(name: 'building_id') required String buildingId,
    @HiveField(3) @JsonKey(name: 'elevator_id') required String elevatorId,
    @HiveField(4) @JsonKey(name: 'technician_id') required String technicianId,
    @HiveField(5) required MaintenanceType type,
    @HiveField(6) required int cost,
    @HiveField(7) String? notes,
    @HiveField(8) @Default([]) List<String> media,
    @HiveField(9) required MaintenanceStatus status,
    @HiveField(10) required DateTime date,
    @HiveField(11) @JsonKey(name: 'created_at') required DateTime createdAt,
    @HiveField(12) @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _MaintainanceModel;

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceModelFromJson(json);

  factory MaintenanceModel.empty() => MaintenanceModel(
        id: '',
        userId: '',
        elevatorId: '',
        buildingId: '',
        technicianId: '',
        type: MaintenanceType.inspection,
        cost: 300,
        notes: null,
        media: [],
        status: MaintenanceStatus.inProgress,
        date: DateTime(2020, 1, 1),
        createdAt: DateTime(2020, 1, 1),
        updatedAt: DateTime(2020, 1, 1),
      );
}
