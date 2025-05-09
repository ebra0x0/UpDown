import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/features/auth/data/repos/auth_repo_imp.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo_imp.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo_imp.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo_imp.dart';
import 'package:UpDown/features/home/data/repo/home_repo_imp.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo_imp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final gitIt = GetIt.instance;

void setupServiceLocator() {
  gitIt.registerSingleton<AppRouter>(AppRouter());
  gitIt.registerSingleton<ApiService>(ApiService(Supabase.instance.client));
  gitIt.registerSingleton<AuthRepoImp>(AuthRepoImp(gitIt.get<ApiService>()));
  gitIt.registerSingleton<ProfileRepoImp>(
      ProfileRepoImp(gitIt.get<ApiService>()));
  gitIt.registerSingleton<HomeRepoImp>(HomeRepoImp(gitIt.get<ApiService>()));
  gitIt
      .registerSingleton<IssuesRepoImp>(IssuesRepoImp(gitIt.get<ApiService>()));
  gitIt.registerSingleton<ElevatorRepoImp>(
      ElevatorRepoImp(gitIt.get<ApiService>()));
  gitIt.registerSingleton<BuildingsRepoImp>(
      BuildingsRepoImp(gitIt.get<ApiService>()));
  gitIt.registerSingleton<SecureStorage>(SecureStorage(FlutterSecureStorage()));
}
