import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      decoration: buildBoxDecoration(),
      child: Row(
        children: <Widget>[
          if (size.width <= 700)
            IconButton(
              onPressed: () {
                // SideMenuProvider.toggleMenu();
              },
              icon: const Icon(Icons.menu_outlined),
            ),
          const SizedBox(width: 5),
          // Search input
          // if (size.width > 390)
          // ConstrainedBox(
          //   constraints: const BoxConstraints(maxWidth: 250),
          //   child: const SearchText(),
          // ),
          // const Spacer(),
          // const NotificationsIndicator(),
          // const SizedBox(width: 5),
          // const NavbarAvatar(),
          // const SizedBox(width: 5),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      );
}
