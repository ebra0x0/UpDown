import 'package:UpDown/core/network/api/api_init.dart';
import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/core/network/net_connection_init.dart';
import 'package:UpDown/core/network/network_cubit.dart';
import 'package:UpDown/core/network/network_manager.dart';
import 'package:UpDown/core/router/app_router.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/theme/cubit/theme_cubit.dart';
import 'package:UpDown/features/auth/data/repos/auth_repo.dart';
import 'package:UpDown/features/auth/data/sources/local.dart';
import 'package:UpDown/features/auth/data/sources/remote.dart';
import 'package:UpDown/features/auth/ui/cubit/auth_cubit.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo.dart';
import 'package:UpDown/features/buildings/data/sources/local.dart';
import 'package:UpDown/features/buildings/data/sources/remote.dart';
import 'package:UpDown/features/buildings/presentation/cubits/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo.dart';
import 'package:UpDown/features/elevators/data/sources/local.dart';
import 'package:UpDown/features/elevators/data/sources/remote.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:UpDown/features/issues/data/sources/local.dart';
import 'package:UpDown/features/issues/data/sources/remote.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo.dart';
import 'package:UpDown/features/profile/data/sources/local/local.dart';
import 'package:UpDown/features/profile/data/sources/remote/remote.dart';
import 'package:UpDown/features/profile/presentation/manager/profile_cubit/cubit/profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final GetIt getIt = GetIt.instance;
void setupDependancyInjection() {
  // Network

  getIt.registerSingleton<InternetConnection>(internetConnectionInit());
  getIt.registerSingleton<NetworkManager>(NetworkManager(getIt()));
  getIt.registerSingleton<NetworkCubit>(NetworkCubit(getIt()));

  // ApiService
  getIt.registerSingleton<ApiInitializer>(ApiInitializer(getIt()));
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt(), getIt()));

  // Theme
  getIt.registerSingleton<AppTheme>(AppTheme());
  getIt.registerSingleton<ThemeCubit>(ThemeCubit());

  // Router
  getIt.registerLazySingleton<GoRouter>(() => AppRouter.router());

  // Auth
  getIt.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt()));
  getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepo(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(authRepo: getIt()));

  // Buildings
  getIt.registerLazySingleton<BuildingsLocalDataSource>(
    () => BuildingsLocalDataSource(),
  );
  getIt.registerLazySingleton<BuildingsRemoteDataSource>(
      () => BuildingsRemoteDataSource(getIt()));

  getIt.registerLazySingleton<BuildingsRepo>(
      () => BuildingsRepo(getIt(), getIt(), getIt()));
  getIt.registerFactory<BuildingsCubit>(() => BuildingsCubit(getIt()));

  // Issues
  getIt.registerLazySingleton<IssuesLocalDataSource>(
      () => IssuesLocalDataSource());
  getIt.registerLazySingleton<IssuesRemoteDataSource>(
      () => IssuesRemoteDataSource(getIt()));
  getIt.registerLazySingleton<IssuesRepo>(
      () => IssuesRepo(getIt(), getIt(), getIt()));
  getIt.registerFactory<IssuesCubit>(() => IssuesCubit(getIt()));

  // Elevators
  getIt.registerLazySingleton<ElevatorsLocalDataSource>(
      () => ElevatorsLocalDataSource());
  getIt.registerLazySingleton<ElevatorsRemoteDataSource>(
      () => ElevatorsRemoteDataSource(getIt()));
  getIt.registerLazySingleton<ElevatorsRepo>(
      () => ElevatorsRepo(getIt(), getIt(), getIt()));
  getIt.registerFactory<ElevatorsCubit>(() => ElevatorsCubit(getIt()));

  // Profile
  getIt.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSource());
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(getIt()));
  getIt.registerLazySingleton<ProfileRepo>(
      () => ProfileRepo(getIt(), getIt(), getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
}
