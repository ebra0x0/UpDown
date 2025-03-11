import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/features/root/create_issue/data/repos/create_issue_repo_imp.dart';
import 'package:UpDown/features/root/home/data/repos/building_repo/building_repo_imp.dart';
import 'package:UpDown/features/root/home/data/repos/elevator_repo/elevator_repo_imp.dart';
import 'package:UpDown/features/root/home/data/repos/home_repo/home_repo_imp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final gitIt = GetIt.instance;

void setupServiceLocator() {
  gitIt.registerSingleton<ApiService>(ApiService(Supabase.instance.client));
  gitIt.registerSingleton<HomeRepoImp>(HomeRepoImp(gitIt.get<ApiService>()));
  gitIt.registerSingleton<CreateIssueRepoImp>(CreateIssueRepoImp());
  gitIt.registerSingleton<ElevatorRepoImp>(ElevatorRepoImp());
  gitIt.registerSingleton<BuildingRepoImp>(
      BuildingRepoImp(gitIt.get<ApiService>()));
  gitIt.registerSingleton<SecureStorage>(SecureStorage(FlutterSecureStorage()));
}
