import 'package:fl_admin_dashboard/features/auth/auth.dart';
import 'package:fl_admin_dashboard/features/dashboard/dashboard.dart';
import 'package:fl_admin_dashboard/features/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_router_notifier.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final routerNotifier = ref.read(appRouterNotifier);
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: SplashScreen.route,
    refreshListenable: routerNotifier,
    routes: <RouteBase>[
      // * Ruta de espera
      GoRoute(
        path: SplashScreen.route,
        pageBuilder: FadeTransitionRoute.route(const SplashScreen()),
      ),
      // * Rutas de autenticacion
      GoRoute(
        path: AuthLayout.path,
        redirect: (context, state) {
          if (state.fullPath == AuthLayout.path) return LoginView.fullRoute;
          return null;
        },
        routes: [
          ShellRoute(
            builder: (_, __, child) => AuthLayout(child: child),
            routes: [
              GoRoute(
                path: LoginView.route,
                pageBuilder: FadeTransitionRoute.route(const LoginView()),
              ),
              GoRoute(
                path: RegisterView.route,
                pageBuilder: FadeTransitionRoute.route(const RegisterView()),
              ),
            ],
          ),
        ],
      ),
      // * Rutas de dashboard
      GoRoute(
        path: DashboardScreen.route,
        pageBuilder: FadeTransitionRoute.route(const DashboardScreen()),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.fullPath ?? '';
      final authStatus = ref.read(authStateProvider);
      // Si estamos cargando, solo puede estar en el splash screen
      if (isGoingTo == SplashScreen.route && authStatus.isChecking) return null;
      // Si no está autenticado, solo puede navegar por el auth
      if (authStatus.status == AuthStatus.notauthenticated) {
        if (isGoingTo.contains(AuthLayout.path)) return null;
        return LoginView.fullRoute;
      }
      // Si está autenticado, navega solo por el dashboard
      if (authStatus.status == AuthStatus.authenticated) {
        if (!isGoingTo.contains(DashboardScreen.route)) {
          return DashboardScreen.route;
        }
        return DashboardScreen.route;
      }
      return null;
    },
  );
}
