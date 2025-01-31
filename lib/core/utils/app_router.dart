import 'package:UpDown/features/auth/presentaion/views/login/login_view.dart';
import 'package:UpDown/features/auth/presentaion/views/registration/registration_view.dart';
import 'package:UpDown/features/create_report/presentation/views/create_report_view.dart';
import 'package:UpDown/features/home/presentation/manager/buildings_cubit/cubit/buildings_cubit.dart';
import 'package:UpDown/features/home/presentation/manager/elevator_cubit/cubit/elevator_cubit.dart';
import 'package:UpDown/features/home/presentation/manager/home_cubit/cubit/home_cubit.dart';
import 'package:UpDown/features/home/presentation/views/building_details_view.dart';
import 'package:UpDown/features/home/presentation/views/elevator_details_view.dart';
import 'package:UpDown/features/splash/presentation/views/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/views/home_view.dart';

abstract class AppRouter {
  static const String ksplashView = '/splashView';
  static const String khomeView = '/homeView';
  static const String kcreateReportView = '/createReportView';
  static const String kregistrationView = '/registrationView';
  static const String kloginView = '/loginView';
  static const String kauthListener = '/authListener';
  static const String kbuildingDetails = '/buildingDetails';
  static const String kelevatorDetails = '/elevatorDetails';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      // builder: (context, state) => const HomeView(),
      builder: (context, state) => BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..fetchBuildingsSummary(),
          child: const HomeView()),
    ),
    GoRoute(
      path: ksplashView,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
        path: kbuildingDetails,
        builder: (context, state) {
          final String buildingId = state.extra as String;
          return BlocProvider(
              create: (context) =>
                  BuildingsCubit()..getBuildingDetails(buildingId: buildingId),
              child: BuildingDetailsView());
        }),
    GoRoute(
        path: kelevatorDetails,
        builder: (context, state) {
          final String elevatorId = state.extra as String;
          return BlocProvider(
              create: (context) =>
                  ElevatorCubit()..getElevatorDetails(elevatorId: elevatorId),
              child: ElevatorDetailsView());
        }),
    GoRoute(
      path: kregistrationView,
      builder: (context, state) => const RegistrationView(),
    ),
    GoRoute(
      path: kloginView,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: khomeView,
      builder: (context, state) => BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..fetchBuildingsSummary(),
          child: const HomeView()),
    ),
    GoRoute(
      path: kcreateReportView,
      builder: (context, state) => const CreateReportView(),
    ),
  ]);
}
