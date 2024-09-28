import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../presentation/screens/screens.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: HomeScreen.route,
    routes: [
      GoRoute(
        path: HomeScreen.route,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: LoginScreen.route,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: RegisterScreen.route,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
    ],
  );
}
