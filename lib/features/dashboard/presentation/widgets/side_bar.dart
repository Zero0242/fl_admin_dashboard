import 'package:fl_admin_dashboard/features/auth/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';

class Sidebar extends ConsumerStatefulWidget {
  const Sidebar({
    super.key,
    required this.currentRoute,
    required this.goBranch,
  });

  final String? currentRoute;
  final void Function(int index) goBranch;

  @override
  ConsumerState<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar> {
  void _navigateTo(int index) {
    widget.goBranch(index);
    ref.read(dashboardSidebarProvider.notifier).closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'main'),
          MenuItem(
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            isActive: widget.currentRoute == DashboardView.fullRoute,
            onTap: () => _navigateTo(0),
          ),
          const MenuItem(text: 'Orders', icon: Icons.shopping_cart_outlined),
          MenuItem(
            text: 'Categories',
            icon: Icons.category_outlined,
            isActive: widget.currentRoute == CategoriesView.fullRoute,
            onTap: () => _navigateTo(1),
          ),
          const MenuItem(text: 'Products', icon: Icons.dashboard_outlined),
          const MenuItem(text: 'Discount', icon: Icons.attach_money),
          MenuItem(
            text: 'Users',
            icon: Icons.people_alt_outlined,
            isActive:
                widget.currentRoute?.contains(UsersView.fullRoute) ?? false,
            onTap: () {
              context.go(UsersView.fullRoute);
            },
          ),
          const SizedBox(height: 30),
          const TextSeparator(text: 'UI Elements'),
          MenuItem(
            text: 'Icons',
            icon: Icons.list_outlined,
            isActive: widget.currentRoute == IconsView.fullRoute,
            onTap: () => _navigateTo(3),
          ),
          const MenuItem(text: 'Marketing', icon: Icons.campaign_outlined),
          const MenuItem(text: 'Campaign', icon: Icons.note_add_outlined),
          MenuItem(
            text: 'Blank',
            icon: Icons.post_add_outlined,
            isActive: widget.currentRoute == BlankView.fullRoute,
            onTap: () => _navigateTo(4),
          ),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Exit'),
          MenuItem(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
            onTap: () => ref.read(authStateProvider.notifier).logout(),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xff092044),
          Color(0xff092042),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
        ),
      ],
    );
  }
}
