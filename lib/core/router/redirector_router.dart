import 'package:UpDown/core/router/strategies/auth_redirect_strategy.dart';
import 'package:UpDown/core/router/strategies/authenticated_redirect_strategy.dart';
import 'package:UpDown/core/router/strategies/new_account_redirect_strategy.dart';
import 'package:UpDown/core/router/strategies/unauthenticated_redirect_strategy.dart';
import 'package:UpDown/core/router/strategies/unconfirmed_redirect_strategy.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/auth/ui/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class RedirectRouter {
  final Map<AuthStatus, AuthRedirectStrategy> _authStrategies = {
    AuthStatus.authenticated: AuthenticatedRedirectStrategy(),
    AuthStatus.unAuthenticated: UnAuthenticatedRedirectStrategy(),
    AuthStatus.error: UnAuthenticatedRedirectStrategy(),
    AuthStatus.firstTime: NewAccountRedirectStrategy(),
    AuthStatus.unconfirmed: UnconfirmedRedirectStrategy(),
  };

  final AuthCubit _authCubit;

  RedirectRouter({
    required AuthCubit authCubit,
  }) : _authCubit = authCubit;

  String? redirect(GoRouterState state) {
    final authState = _authCubit.state;

    final authStrategy = _authStrategies[authState.status];
    return authStrategy?.redirect(
        state.fullPath ?? AppRoute.splash.path, authState.status);
  }
}
