import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/features/auth/presentaion/views/login/login_view.dart';
import 'package:UpDown/features/auth/presentaion/views/registration/registration_view.dart';
import 'package:UpDown/features/root/create_issue/presentation/manager/cubit/create_issue_cubit.dart';
import 'package:UpDown/features/root/create_issue/presentation/views/create_issue_view.dart';
import 'package:UpDown/features/root/home/presentation/manager/buildings_cubit/cubit/buildings_cubit.dart';
import 'package:UpDown/features/root/home/presentation/manager/elevator_cubit/cubit/elevator_cubit.dart';
import 'package:UpDown/features/root/home/presentation/manager/home_cubit/cubit/home_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/building_details_view.dart';
import 'package:UpDown/features/root/home/presentation/views/elevator_details_view.dart';
import 'package:UpDown/features/root/root_view.dart';
import 'package:UpDown/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/root/home/presentation/views/home_view.dart';

abstract class AppRouter {
  static const String kregistrationView = '/registrationView';
  static const String kloginView = '/loginView';
  static const String khomeView = '/homeView';
  static const String kcreateIssueView = '/createReportView';
  static const String kbuildingDetails = 'buildingDetails/:buildingId';
  static const String kelevatorDetails = '/elevatorDetails/:elevatorId';

  static void goToBuildingDetails(BuildContext context, String buildingId) {
    context.push('$khomeView/buildingDetails/$buildingId');
  }

  static void goToElevatorDetails(BuildContext context, String elevatorId) {
    context.push('$khomeView/elevatorDetails/$elevatorId');
  }

  static GoRouter get router {
    return GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kregistrationView,
        builder: (context, state) => const RegistrationView(),
      ),
      GoRoute(
        path: kloginView,
        builder: (context, state) => const LoginView(),
      ),
      ShellRoute(
          builder: (context, state, child) => MultiBlocProvider(providers: [
                BlocProvider<BuildingsCubit>(
                    create: (context) => BuildingsCubit()),
                BlocProvider<ElevatorCubit>(
                    create: (context) => ElevatorCubit()),
                BlocProvider<CreateIssueCubit>(
                    create: (context) => CreateIssueCubit(
                          buildings: BlocProvider.of<UserDataCubit>(context)
                              .userData!
                              .buildings,
                          elevators: BlocProvider.of<UserDataCubit>(context)
                              .userData!
                              .elevators,
                        )),
                BlocProvider<HomeCubit>(
                    create: (context) =>
                        HomeCubit()..fetchBuildingsSummary(context)),
              ], child: RootView(child: child)),
          routes: [
            GoRoute(
                path: khomeView,
                builder: (context, state) => const HomeView(),
                routes: [
                  GoRoute(
                    path: kbuildingDetails,
                    builder: (context, state) {
                      final String buildingId =
                          state.pathParameters['buildingId']!;
                      final cubit = BlocProvider.of<BuildingsCubit>(context);

                      return BlocProvider.value(
                        value: cubit
                          ..getBuildingDetails(buildingId: buildingId),
                        child: BuildingDetailsView(),
                      );
                    },
                  ),
                  GoRoute(
                    path: kelevatorDetails,
                    builder: (context, state) {
                      final String elevatorId =
                          state.pathParameters['elevatorId']!;
                      final cubit = BlocProvider.of<ElevatorCubit>(context);

                      return BlocProvider.value(
                        value: cubit
                          ..getElevatorDetails(elevatorId: elevatorId),
                        child: ElevatorDetailsView(),
                      );
                    },
                  ),
                ]),
            GoRoute(
              path: kcreateIssueView,
              builder: (context, state) => BlocProvider.value(
                value: BlocProvider.of<CreateIssueCubit>(context),
                child: CreateIssueView(),
              ),
            ),
          ]),
    ]);
  }
}
