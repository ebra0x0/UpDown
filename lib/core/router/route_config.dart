import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/core/network/widgets/offline_view.dart';
import 'package:UpDown/core/router/shell_route_config.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/features/account_setup/data/repos/account_setup_repo.dart';
import 'package:UpDown/features/account_setup/ui/cubit/account_setup_cubit.dart';
import 'package:UpDown/features/account_setup/ui/views/account_setup_view.dart';
import 'package:UpDown/features/auth/ui/views/login/login_view.dart';
import 'package:UpDown/features/auth/ui/views/regestration/registration_view.dart';
import 'package:UpDown/features/buildings/presentation/views/building_details_view.dart';
import 'package:UpDown/features/elevators/presentation/views/elevator_details_view.dart';
import 'package:UpDown/features/home/presentation/views/home_view.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/issues/presentation/views/create_issue_view.dart';
import 'package:UpDown/features/issues/presentation/views/issue_view.dart';
import 'package:UpDown/features/issues/presentation/views/issues_list_view.dart';
import 'package:UpDown/features/maintenances/presentation/views/maintenance_list_view.dart';
import 'package:UpDown/features/profile/presentation/manager/profile_cubit/cubit/profile_cubit.dart';
import 'package:UpDown/features/profile/presentation/views/profile_view.dart';
import 'package:UpDown/features/splash/presentation/views/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static List<RouteBase> getRoutes() => [
        ..._authRoutes(),
        ShellRouteConfig.getShellRoute(),
        GoRoute(
          path: AppRoute.offline.path,
          builder: (context, state) => const OfflineView(),
        ),
      ];
  static List<GoRoute> _authRoutes() => [
        GoRoute(
          path: AppRoute.splash.path,
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: AppRoute.login.path,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: AppRoute.registration.path,
          builder: (context, state) => const RegistrationView(),
        ),
        GoRoute(
          path: AppRoute.accountSetup.path,
          builder: (context, state) => BlocProvider(
            create: (context) => AccountSetupCubit(AccountSetupRepo(getIt())),
            child: const AccountSetupView(),
          ),
        ),
      ];

  static List<StatefulShellBranch> getShellBranches() => [
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoute.home.path,
            builder: (context, state) => const HomeView(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoute.createIssue.path,
            builder: (context, state) => BlocProvider(
              create: (context) => CreateIssueCubit(getIt(), getIt()),
              child: const CreateIssueView(),
            ),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoute.profile.path,
            builder: (context, state) => BlocProvider(
                create: (context) => getIt<ProfileCubit>(),
                child: const ProfileView()),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoute.home.path,
              builder: (context, state) => const HomeView(),
              routes: [
                _buildingDetailsRoute(),
                _elevatorDetailsRoute(),
                _issueDetailsRoute(),
                _issuesListRoute(),
                _maintenancesListRoute(),
              ]),
        ]),
      ];

  static GoRoute _issueDetailsRoute() {
    return GoRoute(
      path: "${AppRoute.issue.path}/:id",
      builder: (context, state) {
        return IssueView(issueId: state.pathParameters['id'] as String);
      },
    );
  }

  static GoRoute _elevatorDetailsRoute() {
    return GoRoute(
        path: "${AppRoute.elevator.path}/:id",
        builder: (context, state) {
          return ElevatorDetailsView(
            elevatorId: state.pathParameters['id'] as String,
          );
        });
  }

  static GoRoute _buildingDetailsRoute() {
    return GoRoute(
        path: "${AppRoute.building.path}/:id",
        builder: (context, state) {
          return BuildingDetailsView(
            buildingId: state.pathParameters['id'] as String,
          );
        });
  }

  static GoRoute _issuesListRoute() {
    return GoRoute(
        path: AppRoute.issues.path,
        builder: (context, state) {
          return IssuesListView();
        });
  }

  static GoRoute _maintenancesListRoute() {
    return GoRoute(
        path: AppRoute.maintenances.path,
        builder: (context, state) {
          return MaintenanceListView();
        });
  }
}
