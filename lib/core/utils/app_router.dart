import 'package:UpDown/features/auth/presentaion/views/registration_view.dart';
import 'package:UpDown/features/create_report/presentation/views/create_report_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/views/home_view.dart';

abstract class AppRouter {
  static const String khomeView = '/homeView';
  static const String kcreateReportView = '/createReportView';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RegistrationView(),
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
