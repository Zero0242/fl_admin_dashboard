import 'package:admin_dashboard/helpers/context_extensions.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/navbar.dart';
import 'package:flutter/material.dart';

import '../../shared/sidebar.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({super.key, required this.child});
  final Widget child;

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SideMenuProvider.menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedf1f2),
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              if (context.width > 700) const Sidebar(),
              Expanded(
                child: Column(
                  children: <Widget>[
                    // NavBar
                    const NavBar(),
                    // View
                    Expanded(child: widget.child),
                  ],
                ),
              ),
            ],
          ),
          if (context.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, child) {
                return Stack(
                  children: <Widget>[
                    if (SideMenuProvider.isMenuOpen)
                      Opacity(
                        opacity: SideMenuProvider.opacity.value,
                        child: GestureDetector(
                          onTap: SideMenuProvider.closeMenu,
                          child: Container(
                            width: context.width,
                            height: context.height,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    Transform.translate(
                      offset: Offset(SideMenuProvider.movement.value, 0),
                      child: const Sidebar(),
                    ),
                  ],
                );
              },
            )
        ],
      ),
    );
  }
}
