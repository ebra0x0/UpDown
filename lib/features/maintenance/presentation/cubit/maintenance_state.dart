import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';

class MaintenanceState {
  final ContentStatus status;
  final String? error;
  final List<MaintenanceModel>? maintenances;
  final MaintenanceModel? currentMaintenance;

  const MaintenanceState({
    this.status = ContentStatus.initial,
    this.error,
    this.maintenances,
    this.currentMaintenance,
  });

  MaintenanceState copyWith({
    ContentStatus? status,
    String? error,
    List<MaintenanceModel>? maintenances,
    MaintenanceModel? currentMaintenance,
  }) =>
      MaintenanceState(
        status: status ?? this.status,
        error: error ?? this.error,
        maintenances: maintenances ?? this.maintenances,
        currentMaintenance: currentMaintenance ?? this.currentMaintenance,
      );
}
