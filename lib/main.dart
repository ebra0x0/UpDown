import 'package:UpDown/core/network/api_init.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/core/storage/hive/hive_setup.dart';
import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/updown.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  // Initialization
  WidgetsFlutterBinding.ensureInitialized();
  NetworkManager.init();
  await hiveSetup();
  await ApiInitializer.init();
  setupDependancyInjection();

  runApp(UpDown());
}
