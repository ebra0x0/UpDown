import 'package:UpDown/core/network/api_init.dart';
import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/core/network/network_cubit.dart';
import 'package:UpDown/core/router/app_router.dart';
import 'package:UpDown/core/storage/secure/secure_service.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/manager/theme_cubit.dart';
import 'package:UpDown/core/storage/secure/secure_storage.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/features/auth/repos/auth_repo.dart';
import 'package:UpDown/features/auth/repos/auth_repo_imp.dart';
import 'package:UpDown/features/auth/repos/token_repo.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo_imp.dart';
import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo_imp.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo_imp.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final GetIt getIt = GetIt.instance;
void setupDependancyInjection() {
  // ApiService
  getIt.registerLazySingleton<ApiService>(
      () => ApiService(ApiInitializer.client));

  // SecureStorage
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
  getIt.registerLazySingleton<SecureStorage>(
      () => SecureStorageService(getIt()));
  getIt.registerLazySingleton<TokenRepository>(() => TokenRepository(getIt()));

  // Theme
  getIt.registerLazySingleton<AppTheme>(() => AppTheme());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // Network
  getIt.registerLazySingleton<NetworkCubit>(() => NetworkCubit());

  // Router
  getIt.registerLazySingleton<GoRouter>(() => AppRouter.router());

  // Auth
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImp(getIt()));
  getIt.registerLazySingleton<AuthCubit>(
      () => AuthCubit(authRepo: getIt(), tokenRepo: getIt()));

  // Buildings
  getIt.registerLazySingleton<BuildingsRepo>(() => BuildingsRepoImp(getIt()));
  getIt.registerLazySingleton<BuildingsCubit>(() => BuildingsCubit(getIt()));

  // Issues
  getIt.registerLazySingleton<IssuesRepo>(() => IssuesRepoImp(getIt()));
  getIt.registerLazySingleton<IssuesCubit>(() => IssuesCubit(getIt()));

  // Elevators
  getIt.registerLazySingleton<ElevatorsRepo>(() => ElevatorsRepoImp(getIt()));
  getIt.registerLazySingleton<ElevatorsCubit>(() => ElevatorsCubit(getIt()));
}
