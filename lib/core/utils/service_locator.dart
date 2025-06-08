import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/shared_pref.dart';
import 'package:UpDown/features/account_setup/data/repos/account_setup_repo_imp.dart';
import 'package:UpDown/features/auth/repos/auth_repo_imp.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo_imp.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo_imp.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo_imp.dart';
import 'package:UpDown/features/home/data/repo/home_repo_imp.dart';
import 'package:UpDown/features/profile/data/data_sources/local_data_source/local_data_source_imp.dart';
import 'package:UpDown/features/profile/data/data_sources/remote_data_source/remote_data_source_imp.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo_imp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final gitIt = GetIt.instance;

Future<void> serviceLocatorSetup() async {
  // AppRouter
  gitIt.registerSingleton<AppRouter>(AppRouter());
  // ApiService
  gitIt.registerSingleton<ApiService>(ApiService(Supabase.instance.client));
  // AuthRepo
  gitIt.registerSingleton<AuthRepoImp>(AuthRepoImp(gitIt.get<ApiService>()));
  // AccountSetupRepo
  gitIt.registerSingleton<AccountSetupRepoImp>(
      AccountSetupRepoImp(gitIt.get<ApiService>()));
  // ProfileRepo
  gitIt.registerSingleton<ProfileRepoImp>(ProfileRepoImp(
      ProfileLocalDataSourceImp(),
      ProfileRemoteDataSourceImp(gitIt.get<ApiService>())));
  // HomeRepo
  gitIt.registerSingleton<HomeRepoImp>(HomeRepoImp(gitIt.get<ApiService>()));
  // IssuesRepo
  gitIt
      .registerSingleton<IssuesRepoImp>(IssuesRepoImp(gitIt.get<ApiService>()));
  // ElevatorRepo
  gitIt.registerSingleton<ElevatorRepoImp>(
      ElevatorRepoImp(gitIt.get<ApiService>()));
  // BuildingsRepo
  gitIt.registerSingleton<BuildingsRepoImp>(
      BuildingsRepoImp(gitIt.get<ApiService>()));
  // SecureStorage
  gitIt.registerSingleton<SecureStorage>(SecureStorage(FlutterSecureStorage()));
  // SharedPreferences
  gitIt.registerSingleton<SharedPref>(
      SharedPref(await SharedPreferences.getInstance()));
  // Theme
  gitIt.registerSingleton<AppTheme>(AppTheme());
}
