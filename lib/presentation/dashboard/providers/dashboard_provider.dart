import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardSidebarProvider =
    StateNotifierProvider<DashboardSidebarNotifier, DashboardSidebarState>(
        (ref) {
  return DashboardSidebarNotifier();
});

class DashboardSidebarNotifier extends StateNotifier<DashboardSidebarState> {
  DashboardSidebarNotifier() : super(DashboardSidebarState());

  void setController(AnimationController value) {
    if (state.controller != null) return;
    state = state.copyWith(controller: value);
  }

  void openMenu() {
    state = state.copyWith(isOpen: true);
    state.controller?.forward();
  }

  void closeMenu() {
    state = state.copyWith(isOpen: false);
    state.controller?.reverse();
  }

  void toggleMenu() {
    state.isOpen ? closeMenu() : openMenu();
  }
}

class DashboardSidebarState {
  DashboardSidebarState({this.controller, this.isOpen = true});

  final AnimationController? controller;
  final bool isOpen;

  DashboardSidebarState copyWith({
    AnimationController? controller,
    bool? isOpen,
  }) {
    return DashboardSidebarState(
      controller: controller ?? this.controller,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
