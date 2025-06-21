import 'package:UpDown/core/utils/go_router_refresh_stream.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/account_setup/presentation/views/account_setup_view.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/features/auth/login/presentaion/views/login_view.dart';
import 'package:UpDown/features/auth/registration/presentation/views/registration_view.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo_imp.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo_imp.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/presentation/views/create_issue_view.dart';
import 'package:UpDown/features/buildings/presentation/views/building_details_view.dart';
import 'package:UpDown/features/elevators/presentation/views/elevator_details_view.dart';
import 'package:UpDown/features/home/presentation/views/home_view.dart';
import 'package:UpDown/features/issues/presentation/views/issue_view.dart';
import 'package:UpDown/features/main_shell/root_view.dart';
import 'package:UpDown/features/profile/presentation/views/profile_view.dart';
import 'package:UpDown/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // Auth Paths
  static const String kregistrationView = '/registration';
  static const String kloginView = '/login';
  // Account Setup
  static const String kaccountSetupView = '/accountSetup';
  // Main Paths
  static const String khomeView = '/home';
  static const String kcreateIssueView = '/createIssue';
  static const String kprofileView = '/profile';
  static const String kbuildingDetails = '/buildingDetails';
  static const String kelevatorDetails = '/elevatorDetails';
  static const String kissueView = '/issue';

  GoRouter router(BuildContext context) {
    return GoRouter(
        refreshListenable:
            GoRouterRefreshStream(context.read<AuthCubit>().stream),
        redirect: (context, state) async {
          final authState = context.read<AuthCubit>().state;

          final isGoingToLogin = state.fullPath == kloginView;
          final isGoingToRegister = state.fullPath == kregistrationView;
          final isGoingToSplash = state.fullPath == '/';
          final isGoingToAccountSetup = state.fullPath == kaccountSetupView;
          final isGoingToAuthPages = isGoingToLogin ||
              isGoingToRegister ||
              isGoingToAccountSetup ||
              isGoingToSplash;

          if (authState.status == AuthStatus.authenticated) {
            if (isGoingToAuthPages) {
              return khomeView;
            }
          } else if (authState.status == AuthStatus.unAuthenticated) {
            if (!isGoingToAuthPages) {
              return kloginView;
            } else if (isGoingToSplash) {
              return kloginView;
            }
          } else if (authState.status == AuthStatus.newAccount) {
            return kaccountSetupView;
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
            path: kaccountSetupView,
            builder: (context, state) => const AccountSetupView(),
          ),
          StatefulShellRoute.indexedStack(
              builder: (context, state, navigationShell) =>
                  RootView(navigationShell: navigationShell),
              branches: [
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: khomeView,
                    builder: (context, state) => HomeView(),
                  ),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: kcreateIssueView,
                    builder: (context, state) => const CreateIssueView(),
                  ),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: kprofileView,
                    builder: (context, state) => const ProfileView(),
                  ),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                      path: kbuildingDetails,
                      builder: (context, state) {
                        final String buildingId = state.extra as String;

                        return BlocProvider(
                          create: (context) => BuildingDetailsCubit(
                              gitIt.get<BuildingsRepoImp>()),
                          child: BuildingDetailsView(buildingId: buildingId),
                        );
                      }),
                  GoRoute(
                      path: kelevatorDetails,
                      builder: (context, state) {
                        final String elevatorId = state.extra as String;

                        return BlocProvider(
                          create: (context) => ElevatorDetailsCubit(
                              gitIt.get<ElevatorRepoImp>()),
                          child: ElevatorDetailsView(elevatorId: elevatorId),
                        );
                      }),
                  GoRoute(
                    path: kissueView,
                    builder: (context, state) {
                      final IssueModel issue = state.extra as IssueModel;
                      return IssueView(issue: issue);
                    },
                  ),
                ]),
              ]),
        ]);
  }
}
