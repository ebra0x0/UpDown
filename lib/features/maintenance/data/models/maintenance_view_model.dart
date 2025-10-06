import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';

class MaintenanceViewModel {
  final MaintenanceModel maintenance;
  final String technicianName;
  final String buildingName;
  final String elevatorName;

  MaintenanceViewModel({
    required this.maintenance,
    required this.technicianName,
    required this.buildingName,
    required this.elevatorName,
  });
}
