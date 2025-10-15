import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ElevatorsLocalDataSource {
  static const _boxName = HiveConstants.elevatorsBox;

  Future<LazyBox> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openLazyBox(_boxName);
    }
    return Hive.lazyBox(_boxName);
  }

  Future<ElevatorModel?> get(String id) async {
    final box = await _getBox();

    final elevators = await _getAllElevators(box);

    return elevators[id];
  }

  Future<List<ElevatorModel>> getAll() async {
    final box = await _getBox();

    final elevators = await _getAllElevators(box);

    return elevators.values.toList();
  }

  Future<List<ElevatorModel>> getByBuilding(String buildingId) async {
    final elevators = await getAll();

    return elevators.where((e) => e.buildingId == buildingId).toList();
  }

  Future<void> save(ElevatorModel elevator) async {
    final box = await _getBox();
    final elevators = await _getAllElevators(box);
    elevators[elevator.id] = elevator;

    await Future.wait([
      box.put(HiveConstants.elevatorsKey, elevators),
      box.put(HiveConstants.lastSyncKey, DateTime.now().toIso8601String()),
    ]);
  }

  Future<void> saveAll(List<ElevatorModel> elevatorsList) async {
    final box = await _getBox();

    final elevators = {
      for (final e in elevatorsList) e.id: e,
    };

    await Future.wait([
      box.put(HiveConstants.elevatorsKey, elevators),
      box.put(HiveConstants.lastSyncKey, DateTime.now().toIso8601String()),
    ]);
  }

  Future<void> delete(String id) async {
    final box = await _getBox();
    final elevators = await _getAllElevators(box);

    if (elevators.containsKey(id)) {
      elevators.remove(id);
    }
    await box.put(HiveConstants.elevatorsKey, elevators);
  }

  Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }

  Future<void> close() async {
    if (Hive.isBoxOpen(_boxName)) {
      final box = Hive.lazyBox<ElevatorModel>(_boxName);
      await box.close();
    }
  }

  // Helper function
  Future<Map<String, ElevatorModel>> _getAllElevators(LazyBox box) async {
    final data = await box.get(HiveConstants.elevatorsKey) as Map?;
    return (data ?? {}).cast<String, ElevatorModel>();
  }
}
