import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/dashboard_handlers.dart';
import 'package:admin_dashboard/router/unknown_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static TransitionType defaultTransition = TransitionType.fadeIn;
  // * Auth Router
  static String rootRoute = '/';
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';
  // * Dashboard Router
  static String dashboardRoute = '/dashboard';
  static String iconsRoute = '/dashboard/icons';
  static String blankRoute = '/dashboard/blank';

  static void configureRoute() {
    router.notFoundHandler = UnknownHandlers.noPageFound;
    // * Rutas auth
    router.define(rootRoute, handler: AdminHandlers.login);
    router.define(
      loginRoute,
      handler: AdminHandlers.login,
      transitionType: defaultTransition,
    );
    router.define(
      registerRoute,
      handler: AdminHandlers.register,
      transitionType: defaultTransition,
    );
    // * Rutas dashboard
    router.define(
      dashboardRoute,
      handler: DashboardHandlers.dashboard,
      transitionType: defaultTransition,
    );
    router.define(
      iconsRoute,
      handler: DashboardHandlers.icons,
      transitionType: defaultTransition,
    );
    router.define(
      blankRoute,
      handler: DashboardHandlers.blank,
      transitionType: defaultTransition,
    );
  }
}
