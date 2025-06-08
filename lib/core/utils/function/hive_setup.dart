import 'package:UpDown/core/utils/localization/constants.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> hiveSetup() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(ProfileModelAdapter());

  await Future.wait([
    Hive.openBox(kSettingsBox),
    Hive.openBox(kAuthBox),
    Hive.openBox<ProfileModel>(kProfileBox),
    Hive.openBox(kBuildingsBox),
    Hive.openBox(kElevatorsBox),
    Hive.openBox(kIssuesBox),
  ]);
}
