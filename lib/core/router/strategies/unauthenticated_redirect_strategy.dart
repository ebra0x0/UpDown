import 'package:UpDown/core/router/strategies/auth_redirect_strategy.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';

class UnAuthenticatedRedirectStrategy implements AuthRedirectStrategy {
  @override
  String? redirect(String currentPath, AuthStatus status) {
    final authPages = [
      AppRoute.splash.path,
      AppRoute.login.path,
      AppRoute.registration.path,
      AppRoute.accountSetup.path,
    ];

    if (!authPages.contains(currentPath) ||
        currentPath == AppRoute.splash.path) {
      return AppRoute.login.path;
    }
    return null;
  }
}
