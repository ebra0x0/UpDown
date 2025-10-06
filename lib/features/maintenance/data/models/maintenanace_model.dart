import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'maintenanace_model.freezed.dart';
part 'maintenanace_model.g.dart';

@freezed
class MaintenanceModel with _$MaintenanceModel {
  const factory MaintenanceModel({
    required String id,
    required MaintenanceType type,
    required String buildingId,
    required String elevatorId,
    required int cost,
    required String technicianId,
    String? notes,
    @Default([]) List<String> media,
    required MaintenanceStatus status,
    required DateTime date,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _MaintainanceModel;

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceModelFromJson(json);

  factory MaintenanceModel.empty() => MaintenanceModel(
        id: '',
        type: MaintenanceType.inspection,
        elevatorId: '',
        buildingId: '',
        technicianId: '',
        cost: 300,
        notes: null,
        media: [],
        status: MaintenanceStatus.inProgress,
        date: DateTime(2020, 1, 1),
        createdAt: DateTime(2020, 1, 1),
        updatedAt: DateTime(2020, 1, 1),
      );
}
