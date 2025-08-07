import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/model/media_models/media_response_model.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/models/units/cabin_model.dart';
import 'package:UpDown/features/elevators/data/models/units/control_model.dart';
import 'package:UpDown/features/elevators/data/models/units/counter_model.dart';
import 'package:UpDown/features/elevators/data/models/units/engine_model.dart';
import 'package:UpDown/features/elevators/data/models/units/wires_model.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);

      _registerAdapters();
    } catch (e) {
      throw ('Failed to initialize Hive: $e');
    }
  }

  static void _registerAdapters() {
    Hive.registerAdapter(ProfileResponseModelAdapter());
    Hive.registerAdapter(BuildingModelAdapter());
    Hive.registerAdapter(FloorModelAdapter());
    Hive.registerAdapter(ElevatorModelAdapter());
    Hive.registerAdapter(ElevatorStatusAdapter());
    Hive.registerAdapter(ControlModelAdapter());
    Hive.registerAdapter(BoardModelAdapter());
    Hive.registerAdapter(EngineModelAdapter());
    Hive.registerAdapter(CabinModelAdapter());
    Hive.registerAdapter(PasswordDeviceModelAdapter());
    Hive.registerAdapter(WiresModelAdapter());
    Hive.registerAdapter(CounterModelAdapter());
    Hive.registerAdapter(UnitTypeAdapter());
    Hive.registerAdapter(UnitStatusAdapter());
    Hive.registerAdapter(IssueResponseModelAdapter());
    Hive.registerAdapter(IssueTypeAdapter());
    Hive.registerAdapter(IssuePriorityAdapter());
    Hive.registerAdapter(IssueStatusAdapter());
    Hive.registerAdapter(MediaResponseModelAdapter());
    Hive.registerAdapter(MediaTypeAdapter());
  }
}
