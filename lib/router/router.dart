import 'package:admin_dashboard/router/admin_handlers.dart';
import 'package:admin_dashboard/router/unknown_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();
  // * Auth Router
  static String rootRoute = '/';
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';
  // * Dashboard Router
  static String dashboardRoute = '/dashboard';

  static void configureRoute() {
    router.notFoundHandler = UnknownHandlers.noPageFound;
    router.define(rootRoute, handler: AdminHandlers.login);
    router.define(loginRoute, handler: AdminHandlers.login);
    //router.define(registerRoute, handler: handler);
  }
}
