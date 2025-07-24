import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/core/network/widgets/offline_view.dart';
import 'package:UpDown/core/router/shell_route_config.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/features/account_setup/data/repos/account_setup_repo.dart';
import 'package:UpDown/features/account_setup/presentation/manager/account_setup_cubit.dart';
import 'package:UpDown/features/account_setup/presentation/views/account_setup_view.dart';
import 'package:UpDown/features/auth/ui/views/login/login_view.dart';
import 'package:UpDown/features/auth/ui/views/regestration/registration_view.dart';
import 'package:UpDown/features/buildings/presentation/cubits/building_details_cubit/building_details_cubit.dart';
import 'package:UpDown/features/buildings/presentation/views/building_details_view.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_units_cubit/elevator_units_cubit.dart';
import 'package:UpDown/features/elevators/presentation/views/elevator_details_view.dart';
import 'package:UpDown/features/home/presentation/views/home_view.dart';
import 'package:UpDown/features/issues/presentation/manager/issue_details_cubit/issue_details_cubit.dart';
import 'package:UpDown/features/issues/presentation/views/create_issue_view.dart';
import 'package:UpDown/features/issues/presentation/views/issue_view.dart';
import 'package:UpDown/features/profile/data/sources/local/local.dart';
import 'package:UpDown/features/profile/data/sources/remote/remote.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo.dart';
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
            builder: (context, state) => const CreateIssueView(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoute.profile.path,
            builder: (context, state) => BlocProvider(
                create: (context) => ProfileCubit(ProfileRepo(
                      ProfileLocalDataSource(),
                      ProfileRemoteDataSource(getIt()),
                    )),
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
              ]),
        ]),
      ];

  static GoRoute _issueDetailsRoute() {
    return GoRoute(
      path: "${AppRoute.issue.path}/:id",
      builder: (context, state) {
        return BlocProvider(
          create: (context) => IssueDetailsCubit(getIt()),
          child: IssueView(
            issueId: state.pathParameters["id"] as String,
          ),
        );
      },
    );
  }

  static GoRoute _elevatorDetailsRoute() {
    return GoRoute(
        path: "${AppRoute.elevator.path}/:id",
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ElevatorDetailsCubit(getIt()),
              ),
              BlocProvider(
                create: (context) => ElevatorUnitsCubit(getIt()),
              ),
            ],
            child: ElevatorDetailsView(
              elevatorId: state.pathParameters['id'] as String,
            ),
          );
        });
  }

  static GoRoute _buildingDetailsRoute() {
    return GoRoute(
        path: "${AppRoute.building.path}/:id",
        builder: (context, state) {
          return BlocProvider(
            create: (context) => BuildingDetailsCubit(getIt()),
            child: BuildingDetailsView(
              buildingId: state.pathParameters['id'] as String,
            ),
          );
        });
  }
}
