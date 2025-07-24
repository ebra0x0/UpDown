import 'package:UpDown/core/router/strategies/auth_redirect_strategy.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/core/utils/enums/enums.dart';

class NewAccountRedirectStrategy implements AuthRedirectStrategy {
  @override
  String? redirect(String currentPath, AuthStatus status) {
    return AppRoute.accountSetup.path;
  }
}
