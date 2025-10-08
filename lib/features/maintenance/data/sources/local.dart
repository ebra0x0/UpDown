import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MaintenanceLocalDataSource {
  static const String boxName = 'maintenance_box';

  Future<LazyBox<MaintenanceModel>> _getBox() async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        return await Hive.openLazyBox<MaintenanceModel>(boxName);
      }
      return Hive.lazyBox<MaintenanceModel>(boxName);
    } catch (e) {
      throw ('Failed to open maintenance box: $e');
    }
  }

  Future<MaintenanceModel?> get(String maintenanceId) async {
    try {
      final box = await _getBox();
      return await box.get(maintenanceId);
    } catch (e) {
      throw ('Failed to get maintenance $maintenanceId: $e');
    }
  }

  Future<MaintenanceModel?> getCurrent() async {
    try {
      final box = await _getBox();
      final keys = box.keys.cast<String>();

      for (final key in keys) {
        final maintenance = await box.get(key);
        if (maintenance != null &&
            maintenance.status != MaintenanceStatus.completed) {
          return maintenance;
        }
      }
      return null;
    } catch (e) {
      throw ('Failed to get current maintenance: $e');
    }
  }

  Future<void> save(MaintenanceModel maintenance) async {
    try {
      final box = await _getBox();
      await box.put(maintenance.id, maintenance);
    } catch (e) {
      throw ('Failed to save maintenance ${maintenance.id}: $e');
    }
  }

  Future<void> saveAll(List<MaintenanceModel> maintenances) async {
    try {
      final box = await _getBox();
      for (final maintenance in maintenances) {
        await box.put(maintenance.id, maintenance);
      }
    } catch (e) {
      throw ('Failed to save maintenances: $e');
    }
  }

  Future<List<MaintenanceModel>> getAll() async {
    try {
      final box = await _getBox();
      final keys = box.keys.cast<String>();

      final maintenances = await Future.wait(
        keys.map((key) async => await box.get(key)),
      );

      return maintenances.whereType<MaintenanceModel>().toList();
    } catch (e) {
      throw ('Failed to get all maintenances: $e');
    }
  }

  Future<void> delete(String maintenanceId) async {
    try {
      final box = await _getBox();
      await box.delete(maintenanceId);
    } catch (e) {
      throw ('Failed to delete maintenance $maintenanceId: $e');
    }
  }

  Future<void> clear() async {
    try {
      final box = await _getBox();
      await box.clear();
    } catch (e) {
      throw ('Failed to clear maintenance box: $e');
    }
  }

  Future<void> close() async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        final box = Hive.lazyBox<MaintenanceModel>(boxName);
        await box.close();
      }
    } catch (e) {
      throw ('Failed to close maintenance box: $e');
    }
  }
}
