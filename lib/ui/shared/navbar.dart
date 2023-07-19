import 'package:admin_dashboard/helpers/context_extensions.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/widgets/navbar_avatar.dart';
import 'package:admin_dashboard/ui/shared/widgets/notifications_indicator.dart';
import 'package:admin_dashboard/ui/shared/widgets/search_text.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      decoration: buildBoxDecoration(),
      child: Row(
        children: <Widget>[
          // Todo Borger
          if (context.width <= 700)
            IconButton(
                onPressed: () {
                  SideMenuProvider.toggleMenu();
                },
                icon: const Icon(Icons.menu_outlined)),
          const SizedBox(width: 5),
          // Search input
          if (context.width > 390)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: const SearchText(),
            ),
          const Spacer(),
          const NotificationsIndicator(),
          const SizedBox(width: 5),
          const NavbarAvatar(),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 5),
      ]);
}
