import 'package:UpDown/core/network/api/api_init.dart';
import 'package:UpDown/core/storage/hive/hive_service.dart';
import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/core/utils/bloc_observer.dart';
import 'package:UpDown/updown.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  // Initialization
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await HiveService.init();
  setupDependancyInjection();
  await getIt<ApiInitializer>().start();

  runApp(UpDown());
}
