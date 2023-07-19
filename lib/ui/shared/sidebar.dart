import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const <Widget>[
          Logo(),
          SizedBox(height: 50),
          TextSeparator(text: 'main'),
          MenuItem(text: 'Dashboard', icon: Icons.compass_calibration_outlined),
          MenuItem(text: 'Orders', icon: Icons.shopping_cart_outlined),
          MenuItem(text: 'Analytics', icon: Icons.category_outlined),
          MenuItem(text: 'Products', icon: Icons.dashboard_outlined),
          MenuItem(text: 'Discount', icon: Icons.attach_money),
          MenuItem(text: 'Customers', icon: Icons.people_alt_outlined),
          SizedBox(height: 30),
          TextSeparator(text: 'UI Elements'),
          MenuItem(text: 'Icons', icon: Icons.list_outlined),
          MenuItem(text: 'Marketing', icon: Icons.campaign_outlined),
          MenuItem(text: 'Campaign', icon: Icons.note_add_outlined),
          MenuItem(text: 'Black', icon: Icons.post_add_outlined),
          MenuItem(text: 'Logout', icon: Icons.exit_to_app_outlined),
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
