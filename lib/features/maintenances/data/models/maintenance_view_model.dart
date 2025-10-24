import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/models/technician_model.dart';
import 'package:UpDown/features/maintenances/data/models/maintenanace_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'maintenance_view_model.g.dart';

@HiveType(typeId: HiveTypeIds.maintenanceViewModel)
class MaintenanceViewModel {
  @HiveField(0)
  final MaintenanceModel data;
  @HiveField(1)
  final TechnicianModel technician;

  MaintenanceViewModel({
    required this.data,
    required this.technician,
  });

  factory MaintenanceViewModel.empty() => MaintenanceViewModel(
        data: MaintenanceModel.empty(),
        technician: TechnicianModel.empty(),
      );
}
