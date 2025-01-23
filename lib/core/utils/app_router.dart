import 'package:UpDown/features/auth/presentaion/views/login/login_view.dart';
import 'package:UpDown/features/auth/presentaion/views/registration/registration_view.dart';
import 'package:UpDown/features/create_report/presentation/views/create_report_view.dart';
import 'package:UpDown/features/home/presentation/views/building_details_view.dart';
import 'package:UpDown/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/views/home_view.dart';
import 'model/building_model.dart';

abstract class AppRouter {
  static const String ksplashView = '/splashView';
  static const String khomeView = '/homeView';
  static const String kcreateReportView = '/createReportView';
  static const String kregistrationView = '/registrationView';
  static const String kloginView = '/loginView';
  static const String kauthListener = '/authListener';
  static const String kbuildingDetails = '/buildingDetails';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: ksplashView,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
        path: kbuildingDetails,
        builder: (context, state) {
          final BuildingModel building = state.extra as BuildingModel;
          return BuildingDetailsView(building: building);
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
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: kcreateReportView,
      builder: (context, state) => const CreateReportView(),
    ),
  ]);
}
