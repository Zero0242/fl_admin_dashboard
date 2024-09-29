import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void _navigateTo(String routeName) {
    // NavigationService.navigateTo(routeName);
    // SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<SideMenuProvider>(context);
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const <Widget>[
          // const Logo(),
          // const SizedBox(height: 50),
          // const TextSeparator(text: 'main'),
          // MenuItem(
          //   isActive: provider.currentPage == Flurorouter.dashboardRoute,
          //   text: 'Dashboard',
          //   icon: Icons.compass_calibration_outlined,
          //   onTap: () => _navigateTo(Flurorouter.dashboardRoute),
          // ),
          // const MenuItem(text: 'Orders', icon: Icons.shopping_cart_outlined),
          // MenuItem(
          //   text: 'Categories',
          //   icon: Icons.category_outlined,
          //   isActive: provider.currentPage == Flurorouter.categoriesRoute,
          //   onTap: () => _navigateTo(Flurorouter.categoriesRoute),
          // ),
          // const MenuItem(text: 'Products', icon: Icons.dashboard_outlined),
          // const MenuItem(text: 'Discount', icon: Icons.attach_money),
          // MenuItem(
          //   text: 'Users',
          //   icon: Icons.people_alt_outlined,
          //   onTap: () => _navigateTo(Flurorouter.usersRoute),
          //   isActive: provider.currentPage == Flurorouter.usersRoute,
          // ),
          // const SizedBox(height: 30),
          // const TextSeparator(text: 'UI Elements'),
          // MenuItem(
          //   isActive: provider.currentPage == Flurorouter.iconsRoute,
          //   text: 'Icons',
          //   icon: Icons.list_outlined,
          //   onTap: () => _navigateTo(Flurorouter.iconsRoute),
          // ),
          // const MenuItem(text: 'Marketing', icon: Icons.campaign_outlined),
          // const MenuItem(text: 'Campaign', icon: Icons.note_add_outlined),
          // MenuItem(
          //   text: 'Black',
          //   icon: Icons.post_add_outlined,
          //   onTap: () => _navigateTo(Flurorouter.blankRoute),
          // ),
          // const SizedBox(height: 50),
          // const TextSeparator(text: 'Exit'),
          // Consumer<AuthProvider>(
          //   builder: (_, provider, __) => MenuItem(
          //     text: 'Logout',
          //     icon: Icons.exit_to_app_outlined,
          //     onTap: provider.logout,
          //   ),
          // ),
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
