import 'package:fl_admin_dashboard/app/routes.dart';
import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/presentation/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final currentRoute = router.state.matchedLocation;

    void handleNavigation(String route) {
      Scaffold.of(context).closeDrawer();
      router.go(route);
    }

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
            isActive: currentRoute == DashboardView.fullRoute,
            onTap: () => handleNavigation(DashboardView.fullRoute),
          ),
          const MenuItem(text: 'Orders', icon: Icons.shopping_cart_outlined),
          MenuItem(
            text: 'Categories',
            icon: Icons.category_outlined,
            isActive: currentRoute == CategoriesView.fullRoute,
            onTap: () => handleNavigation(CategoriesView.fullRoute),
          ),
          const MenuItem(text: 'Products', icon: Icons.dashboard_outlined),
          const MenuItem(text: 'Discount', icon: Icons.attach_money),
          MenuItem(
            text: 'Users',
            icon: Icons.people_alt_outlined,
            isActive: currentRoute.contains(UsersView.fullRoute),
            onTap: () => handleNavigation(UsersView.fullRoute),
          ),
          const SizedBox(height: 30),
          const TextSeparator(text: 'UI Elements'),
          MenuItem(
            text: 'Icons',
            icon: Icons.list_outlined,
            isActive: currentRoute == IconsView.fullRoute,
            onTap: () => handleNavigation(IconsView.fullRoute),
          ),
          const MenuItem(text: 'Marketing', icon: Icons.campaign_outlined),
          const MenuItem(text: 'Campaign', icon: Icons.note_add_outlined),
          MenuItem(
            text: 'Blank',
            icon: Icons.post_add_outlined,
            isActive: currentRoute == BlankView.fullRoute,
            onTap: () => handleNavigation(BlankView.fullRoute),
          ),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Exit'),
          MenuItem(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
            onTap: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Color(0xff092044), Color(0xff092042)],
      ),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
    );
  }
}
