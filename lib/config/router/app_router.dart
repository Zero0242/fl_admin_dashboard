import 'package:fl_admin_dashboard/features/auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AuthLayout.path,
    routes: [
      GoRoute(
        path: AuthLayout.path,
        redirect: (context, state) {
          if (state.fullPath == AuthLayout.path) {
            return [AuthLayout.path, LoginView.route].join('/');
          }
          return null;
        },
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return AuthLayout(child: child);
            },
            routes: [
              GoRoute(
                path: LoginView.route,
                builder: (context, state) {
                  return const LoginView();
                },
              ),
              GoRoute(
                path: RegisterView.route,
                builder: (context, state) {
                  return const RegisterView();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
