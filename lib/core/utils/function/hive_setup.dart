import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> hiveSetup() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(ProfileModelAdapter());

  await Future.wait([
    Hive.openBox('settings'),
    Hive.openBox('session'),
    Hive.openBox('profile'),
    Hive.openBox('buildings'),
    Hive.openBox('elevators'),
    Hive.openBox('issues'),
  ]);
}
