import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/core/storage/hive/hive_service.dart';

class UserDataLocalDataSource {
  final List<String> userBoxNames;

  UserDataLocalDataSource(this.userBoxNames);

  Future<void> clearAllUserBoxes() async {
    await getIt<HiveService>().clear(userBoxNames);
  }
}
