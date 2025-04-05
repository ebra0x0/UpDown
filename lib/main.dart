import 'package:UpDown/core/utils/function/api_initialization.dart';
import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/updown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  // Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await apiInitialization();
  setupServiceLocator();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthCubit()..authMonitor()),
    BlocProvider(create: (context) => UserDataCubit()),
  ], child: const UpDown()));
}
