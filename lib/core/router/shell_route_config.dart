import 'package:UpDown/core/router/route_config.dart';
import 'package:UpDown/features/main_shell/root_view.dart';
import 'package:go_router/go_router.dart';

class ShellRouteConfig {
  static StatefulShellRoute getShellRoute() {
    return StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootView(navigationShell: navigationShell),
      branches: RouteConfig.getShellBranches(),
    );
  }
}
