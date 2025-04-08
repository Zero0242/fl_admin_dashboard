import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionRoute {
  /// Sintaxis corta
  static CustomTransitionPage Function(BuildContext, GoRouterState) route(
    Widget child,
  ) {
    return (context, state) {
      return _page(context: context, state: state, child: child);
    };
  }

  /// Sintaxis Larga
  static CustomTransitionPage _page<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
