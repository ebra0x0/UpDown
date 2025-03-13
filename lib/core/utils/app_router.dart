import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/auth/presentaion/views/login/login_view.dart';
import 'package:UpDown/features/auth/presentaion/views/registration/registration_view.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/create_issue/data/repos/create_issue_repo_imp.dart';
import 'package:UpDown/features/root/create_issue/presentation/manager/cubit/create_issue_cubit.dart';
import 'package:UpDown/features/root/create_issue/presentation/views/create_issue_view.dart';
import 'package:UpDown/features/root/home/data/repos/building_repo/building_repo_imp.dart';
import 'package:UpDown/features/root/home/data/repos/elevator_repo/elevator_repo_imp.dart';
import 'package:UpDown/features/root/home/data/repos/home_repo/home_repo_imp.dart';
import 'package:UpDown/features/root/home/presentation/manager/active_issues_cubit/cubit/active_issues_cubit.dart';
import 'package:UpDown/features/root/home/presentation/manager/building_details_cubit/cubit/building_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/manager/elevator_details_cubit/cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/manager/buildings_summary_cubit/cubit/buildings_summary_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/building_details_view.dart';
import 'package:UpDown/features/root/home/presentation/views/elevator_details_view.dart';
import 'package:UpDown/features/root/home/presentation/views/home_view.dart';
import 'package:UpDown/features/root/home/presentation/views/issue_view.dart';
import 'package:UpDown/features/root/root_view.dart';
import 'package:UpDown/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String kregistrationView = '/registrationView';
  static const String kloginView = '/loginView';
  static const String khomeView = '/homeView';
  static const String kissueView = 'issueView';
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
          builder: (context, state, child) => RootView(child: child),
          routes: [
            GoRoute(
                path: khomeView,
                builder: (context, state) => MultiBlocProvider(providers: [
                      BlocProvider(
                        create: (context) =>
                            BuildingsSummaryCubit(gitIt.get<HomeRepoImp>())
                              ..fetchBuildingsSummary(context),
                      ),
                      BlocProvider(
                        create: (context) =>
                            ActiveIssuesCubit(gitIt.get<HomeRepoImp>())
                              ..fetchActiveIssues(),
                      )
                    ], child: HomeView()),
                routes: [
                  GoRoute(
                    path: kbuildingDetails,
                    builder: (context, state) {
                      final String buildingId =
                          state.pathParameters['buildingId']!;
                      return BlocProvider(
                        create: (context) =>
                            BuildingDetailsCubit(gitIt.get<BuildingRepoImp>())
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

                      return BlocProvider(
                          create: (context) =>
                              ElevatorDetailsCubit(gitIt.get<ElevatorRepoImp>())
                                ..getElevatorDetails(elevatorId: elevatorId),
                          child: ElevatorDetailsView());
                    },
                  ),
                  GoRoute(
                    path: kissueView,
                    builder: (context, state) {
                      final issue = state.extra as IssueModel;
                      return IssueView(issue: issue);
                    },
                  ),
                ]),
            GoRoute(
              path: kcreateIssueView,
              builder: (context, state) => BlocProvider(
                create: (context) => CreateIssueCubit(
                  gitIt.get<CreateIssueRepoImp>(),
                  buildings: BlocProvider.of<UserDataCubit>(context)
                      .userData!
                      .buildings,
                  elevators: BlocProvider.of<UserDataCubit>(context)
                      .userData!
                      .elevators,
                ),
                child: const CreateIssueView(),
              ),
            )
          ]),
    ]);
  }
}
