import 'package:fl_admin_dashboard/app/routes.dart';
import 'package:fl_admin_dashboard/domain/auth/auth.dart';
import 'package:fl_admin_dashboard/presentation/auth/auth.dart';
import 'package:fl_admin_dashboard/presentation/dashboard/dashboard.dart';
import 'package:fl_admin_dashboard/presentation/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  /**
   * Esta seccion es donde reemplazamos el changenotifier, para poder usar un valuenotifier
   * para refrescar el router, solo si cambiamos el status actual
   */
  final authListener = ValueNotifier<AuthStatus>(AuthStatus.checking);
  ref.listen(authProvider.select((val) => val.status), (prev, next) {
    authListener.value = next;
  });
  /*  */
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: SplashScreen.route,
    refreshListenable: authListener,
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
        path: DashboardLayout.path,
        redirect: (context, state) {
          if (state.fullPath == DashboardLayout.path) {
            return DashboardView.fullRoute;
          }
          return null;
        },
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return DashboardLayout(shell: navigationShell);
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: DashboardView.route,
                    pageBuilder:
                        FadeTransitionRoute.route(const DashboardView()),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: CategoriesView.route,
                    pageBuilder:
                        FadeTransitionRoute.route(const CategoriesView()),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: UsersView.route,
                    pageBuilder: FadeTransitionRoute.route(const UsersView()),
                  ),
                  GoRoute(
                    path: UserView.route,
                    builder: (context, state) {
                      final uid = state.pathParameters['uid'] ?? '';
                      return UserView(uid: uid);
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: IconsView.route,
                    pageBuilder: FadeTransitionRoute.route(const IconsView()),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: BlankView.route,
                    pageBuilder: FadeTransitionRoute.route(const BlankView()),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.fullPath ?? '';
      final authStatus = ref.read(authProvider);
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
        // TODO: probar casos extremos?
        return null;
      }
      return null;
    },
  );
}
