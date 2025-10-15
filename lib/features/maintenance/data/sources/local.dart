import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/maintenance/data/models/maintenance_view_model.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MaintenanceLocalDataSource {
  static const String boxName = 'maintenance_box';

  Future<LazyBox> _getBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openLazyBox(boxName);
    }
    return Hive.lazyBox(boxName);
  }

  Future<MaintenanceViewModel?> get(String maintenanceId) async {
    final box = await _getBox();
    final maintenances = await _getAllMaintenances(box);
    return maintenances[maintenanceId];
  }

  Future<List<MaintenanceViewModel>> getAll() async {
    final box = await _getBox();
    final maintenances = await _getAllMaintenances(box);
    return maintenances.values.toList();
  }

  Future<MaintenanceViewModel?> getCurrent() async {
    final maintenances = await getAll();
    return maintenances.firstWhereOrNull(
      (m) => m.data.status != MaintenanceStatus.completed,
    );
  }

  Future<void> save(MaintenanceViewModel maintenance) async {
    final box = await _getBox();
    final maintenances = await _getAllMaintenances(box);
    maintenances[maintenance.data.id] = maintenance;

    await Future.wait([
      box.put(HiveConstants.maintenancesKey, maintenances),
      box.put(HiveConstants.lastSyncKey, DateTime.now().toIso8601String()),
    ]);
  }

  Future<void> saveAll(List<MaintenanceViewModel> maintenancesList) async {
    final box = await _getBox();
    final maintenances = {
      for (final m in maintenancesList) m.data.id: m,
    };

    await Future.wait([
      box.put(HiveConstants.maintenancesKey, maintenances),
      box.put(HiveConstants.lastSyncKey, DateTime.now().toIso8601String()),
    ]);
  }

  Future<void> delete(String maintenanceId) async {
    final box = await _getBox();
    final maintenances = await _getAllMaintenances(box);
    if (maintenances.containsKey(maintenanceId)) {
      maintenances.remove(maintenanceId);
    }
    await box.put(HiveConstants.maintenancesKey, maintenances);
  }

  Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }

  Future<void> close() async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.lazyBox(boxName);
      await box.close();
    }
  }

  // Helper function
  Future<Map<String, MaintenanceViewModel>> _getAllMaintenances(
      LazyBox box) async {
    final data = await box.get(HiveConstants.maintenancesKey) as Map?;
    return (data ?? {}).cast<String, MaintenanceViewModel>();
  }
}
