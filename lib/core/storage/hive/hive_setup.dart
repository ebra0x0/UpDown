import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> hiveSetup() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(ProfileResponseModelAdapter());

  await Future.wait([
    Hive.openBox(HiveConstants.settingsBox),
    Hive.openBox<ProfileResponseModel>(HiveConstants.profileBox),
    Hive.openBox(HiveConstants.buildingsBox),
    Hive.openBox(HiveConstants.elevatorsBox),
    Hive.openBox(HiveConstants.issuesBox),
  ]);
}
