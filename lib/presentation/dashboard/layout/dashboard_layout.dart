import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class DashboardLayout extends ConsumerStatefulWidget {
  const DashboardLayout({super.key, required this.shell});
  static const String path = '/dashboard';
  final StatefulNavigationShell shell;

  @override
  ConsumerState<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends ConsumerState<DashboardLayout>
    with SingleTickerProviderStateMixin {
  // Movimiento
  Tween<double> movement = Tween(begin: -200, end: 0);
  // Opacidad
  Tween<double> opacity = Tween(begin: 0, end: 1);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((ts) {
      final menuController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
      ref.read(dashboardSidebarProvider.notifier).setController(menuController);
    });
    super.initState();
  }

  String? get currentRoute {
    return widget.shell.shellRouteContext.routerState.fullPath;
  }

  void onChange(int index) {
    widget.shell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sidebarState = ref.watch(dashboardSidebarProvider);
    final isMenuOpen = sidebarState.isOpen;
    final controller = sidebarState.controller;
    final provider = ref.read(dashboardSidebarProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xffedf1f2),
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              if (size.width > 700)
                Sidebar(
                  currentRoute: currentRoute,
                  goBranch: onChange,
                ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    const NavBar(),
                    Expanded(
                      child: widget.shell,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (size.width < 700)
            AnimatedBuilder(
              animation: controller!,
              builder: (context, child) {
                return Stack(
                  children: <Widget>[
                    if (isMenuOpen)
                      Opacity(
                        opacity: opacity
                            .animate(
                              CurvedAnimation(
                                parent: controller,
                                curve: Curves.easeInOut,
                              ),
                            )
                            .value,
                        child: GestureDetector(
                          onTap: provider.closeMenu,
                          child: Container(
                            width: size.width,
                            height: size.height,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    Transform.translate(
                      offset: Offset(
                        movement
                            .animate(
                              CurvedAnimation(
                                parent: controller,
                                curve: Curves.easeInOut,
                              ),
                            )
                            .value,
                        0,
                      ),
                      child: Sidebar(
                        currentRoute: currentRoute,
                        goBranch: onChange,
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
