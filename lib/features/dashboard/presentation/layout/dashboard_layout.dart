import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({super.key, required this.shell});
  static const String path = '/dashboard';
  final StatefulNavigationShell shell;

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // SideMenuProvider.menuController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 300),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffedf1f2),
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              if (size.width > 700) const Sidebar(),
              Expanded(
                child: Column(
                  children: <Widget>[
                    const NavBar(),
                    Expanded(
                      child: widget.shell,
                    ),
                    // Expanded(child: widget.child),
                  ],
                ),
              ),
            ],
          ),
          // if (size.width < 700)
          //   AnimatedBuilder(
          //     animation: SideMenuProvider.menuController,
          //     builder: (context, child) {
          //       return Stack(
          //         children: <Widget>[
          //           if (SideMenuProvider.isMenuOpen)
          //             Opacity(
          //               opacity: SideMenuProvider.opacity.value,
          //               child: GestureDetector(
          //                 onTap: SideMenuProvider.closeMenu,
          //                 child: Container(
          //                   width: context.width,
          //                   height: context.height,
          //                   color: Colors.black26,
          //                 ),
          //               ),
          //             ),
          //           Transform.translate(
          //             offset: Offset(SideMenuProvider.movement.value, 0),
          //             child: const Sidebar(),
          //           ),
          //         ],
          //       );
          //     },
          //   )
        ],
      ),
    );
  }
}
