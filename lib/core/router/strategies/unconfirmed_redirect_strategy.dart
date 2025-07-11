import 'package:UpDown/core/router/strategies/auth_redirect_strategy.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';

class UnconfirmedRedirectStrategy implements AuthRedirectStrategy {
  @override
  String? redirect(String currentPath, AuthStatus status) {
    return AppRoute.unconfirmed.path;
  }
}
