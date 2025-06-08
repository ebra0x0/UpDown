import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/function/api_setup.dart';
import 'package:UpDown/core/utils/function/hive_setup.dart';
import 'package:UpDown/core/utils/manager/theme_cubit.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/auth/repos/auth_repo_imp.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/updown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  // Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await hiveSetup();
  await apiSetup();
  await serviceLocatorSetup();

  final AuthCubit authCubit = AuthCubit(authRepo: gitIt.get<AuthRepoImp>());
  final AppRouter appRouter = gitIt.get<AppRouter>();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ThemeCubit()..getTheme()),
      BlocProvider(create: (context) => authCubit),
    ],
    child: UpDown(
      appRouter: appRouter,
    ),
  ));
}
