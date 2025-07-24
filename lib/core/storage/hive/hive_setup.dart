import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> hiveSetup() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(ProfileResponseModelAdapter());
  Hive.registerAdapter(FloorModelAdapter());
  Hive.registerAdapter(BuildingModelAdapter());

  await Future.wait([
    Hive.openLazyBox(HiveConstants.authBox),
    Hive.openLazyBox(HiveConstants.settingsBox),
    Hive.openLazyBox<ProfileResponseModel>(HiveConstants.profileBox),
    Hive.openLazyBox<BuildingModel>(HiveConstants.buildingsBox),
    Hive.openLazyBox(HiveConstants.elevatorsBox),
    Hive.openLazyBox(HiveConstants.issuesBox),
  ]);
}
