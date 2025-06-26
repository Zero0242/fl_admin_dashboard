import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_outlined),
            ),
          const SizedBox(width: 5),
          if (size.width > 390)
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

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
  );
}
