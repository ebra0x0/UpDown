import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/core/router/redirector_router.dart';
import 'package:UpDown/core/router/route_config.dart';
import 'package:UpDown/core/utils/go_router_refresh_stream.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

abstract class AppRouter {
  static final redirectRouter = RedirectRouter(
    authCubit: getIt<AuthCubit>(),
  );
  static GoRouter router() {
    final Stream<AuthState> authStateStream = getIt.get<AuthCubit>().stream;
    return GoRouter(
        routes: RouteConfig.getRoutes(),
        navigatorKey: GlobalKey<NavigatorState>(),
        refreshListenable: GoRouterRefreshStream(
          Rx.merge([authStateStream]),
        ),
        redirect: (context, state) async => redirectRouter.redirect(state));
  }
}
