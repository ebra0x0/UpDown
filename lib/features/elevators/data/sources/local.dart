import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ElevatorsLocalDataSource {
  static const _boxName = HiveConstants.elevatorsBox;

  Future<LazyBox<ElevatorModel>> _getBox() async {
    try {
      if (!Hive.isBoxOpen(_boxName)) {
        return await Hive.openLazyBox<ElevatorModel>(_boxName);
      }
      return Hive.lazyBox<ElevatorModel>(_boxName);
    } catch (e) {
      throw ('Failed to open elevators box: $e');
    }
  }

  Future<ElevatorModel?> get(String id) async {
    try {
      final box = await _getBox();
      return await box.get(id);
    } catch (e) {
      throw ('Failed to get elevator $id: $e');
    }
  }

  Future<List<ElevatorModel>> getByBuilding(String buildingId) async {
    try {
      final box = await _getBox();
      final keys = box.keys.cast<String>();
      final elevators = await Future.wait(
        keys.map((key) async => await box.get(key)),
      );
      return elevators
          .whereType<ElevatorModel>()
          .where((e) => e.buildingId == buildingId)
          .toList();
    } catch (e) {
      throw ('Failed to get elevators for building $buildingId: $e');
    }
  }

  Future<void> save(ElevatorModel elevator) async {
    try {
      final box = await _getBox();
      await box.put(elevator.id, elevator);
    } catch (e) {
      throw ('Failed to save elevator ${elevator.id}: $e');
    }
  }

  Future<void> saveAll(List<ElevatorModel> elevators) async {
    try {
      final box = await _getBox();
      await Future.wait(
        elevators.map((elevator) => box.put(elevator.id, elevator)),
      );
    } catch (e) {
      throw ('Failed to save elevators: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      final box = await _getBox();
      if (box.containsKey(id)) {
        await box.delete(id);
      }
    } catch (e) {
      throw ('Failed to delete elevator $id: $e');
    }
  }

  Future<void> clear() async {
    try {
      final box = await _getBox();
      await box.clear();
    } catch (e) {
      throw ('Failed to clear elevators: $e');
    }
  }

  Future<void> closeBox() async {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        final box = Hive.lazyBox<ElevatorModel>(_boxName);
        await box.close();
      }
    } catch (e) {
      throw ('Failed to close elevators box: $e');
    }
  }
}
