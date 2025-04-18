import 'package:UpDown/core/utils/go_router_refresh_stream.dart';
import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/auth/presentaion/views/confirmation/confirmation_view.dart';
import 'package:UpDown/features/auth/presentaion/views/login/login_view.dart';
import 'package:UpDown/features/auth/presentaion/views/registration/registration_view.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/create_issue/data/repos/create_issue_repo_imp.dart';
import 'package:UpDown/features/root/create_issue/presentation/manager/cubit/create_issue_cubit.dart';
import 'package:UpDown/features/root/create_issue/presentation/views/create_issue_view.dart';
import 'package:UpDown/features/root/home/data/repos/building_repo/building_repo_imp.dart';
import 'package:UpDown/features/root/home/data/repos/elevator_repo/elevator_repo_imp.dart';
import 'package:UpDown/features/root/home/presentation/manager/building_details_cubit/cubit/building_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/manager/elevator_details_cubit/cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/building_details_view.dart';
import 'package:UpDown/features/root/home/presentation/views/elevator_details_view.dart';
import 'package:UpDown/features/root/home/presentation/views/home_view.dart';
import 'package:UpDown/features/root/home/presentation/views/issue_view.dart';
import 'package:UpDown/features/root/root_view.dart';
import 'package:UpDown/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String kregistrationView = '/registrationView';
  static const String kloginView = '/loginView';
  static const String kconfirmationView = '/confirmationView/:email';
  static const String khomeView = '/homeView';
  static const String kcreateIssueView = '/createReportView';
  static const String kbuildingDetails = 'buildingDetails/:buildingId';
  static const String kelevatorDetails = '/elevatorDetails/:elevatorId';
  static const String kissueView = 'issueView';

  static void goToBuildingDetails(BuildContext context, String buildingId) {
    context.go("$khomeView/buildingDetails/$buildingId");
  }

  static void goToElevatorDetails(BuildContext context, String elevatorId) {
    context.push("$khomeView/elevatorDetails/$elevatorId");
  }

  static void goToIssueView(BuildContext context, IssueModel issue) {
    context.go("$khomeView/issueView", extra: issue);
  }

  GoRouter router(BuildContext context) {
    return GoRouter(
        refreshListenable:
            GoRouterRefreshStream(context.read<AuthCubit>().stream),
        redirect: (context, state) async {
          final authState = context.read<AuthCubit>().state;

          final isGoingToLogin = state.fullPath == kloginView;
          final isGoingToRegister = state.fullPath == kregistrationView;
          final isGoingToSplash = state.fullPath == '/';
          final isGoingToAuthPages =
              isGoingToLogin || isGoingToRegister || isGoingToSplash;

          if (authState is AuthStateAuthenticated) {
            if (isGoingToAuthPages) {
              loadUserData(context, authState);
              return khomeView;
            }
          } else if (authState is AuthStateUnAuthenticated) {
            if (isGoingToAuthPages) {
              resetUserData(context);
              if (isGoingToSplash) {
                return kloginView;
              }
            } else {
              resetUserData(context);
              return kloginView;
            }
          } else if (authState is AuthStateUnconfirmed) {
            final email = authState.email;
            return kconfirmationView.replaceAll(':email', email);
          }
          return null;
        },
        routes: [
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
          GoRoute(
            path: kconfirmationView,
            builder: (context, state) => ConfirmationView(
              email: state.pathParameters['email'] as String,
            ),
          ),
          ShellRoute(
              builder: (context, state, child) => RootView(child: child),
              routes: [
                GoRoute(
                    path: khomeView,
                    builder: (context, state) => HomeView(),
                    routes: [
                      GoRoute(
                        path: kbuildingDetails,
                        builder: (context, state) {
                          final String buildingId =
                              state.pathParameters['buildingId']!;
                          return BlocProvider(
                            create: (context) => BuildingDetailsCubit(
                                gitIt.get<BuildingRepoImp>())
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
                              create: (context) => ElevatorDetailsCubit(
                                  gitIt.get<ElevatorRepoImp>())
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

  void resetUserData(BuildContext context) {
    if (BlocProvider.of<UserDataCubit>(context).userData != null) {
      BlocProvider.of<UserDataCubit>(context).reset();
    }
  }

  void loadUserData(BuildContext context, AuthStateAuthenticated authState) {
    if (BlocProvider.of<UserDataCubit>(context).userData == null) {
      BlocProvider.of<UserDataCubit>(context)
          .loadUserData(user: authState.session.user);
    }
  }
}
