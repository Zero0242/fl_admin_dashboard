import 'package:fl_admin_dashboard/features/auth/auth.dart';
import 'package:fl_admin_dashboard/features/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AuthLayout.path,
    routes: <RouteBase>[
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
    ],
  );
}
