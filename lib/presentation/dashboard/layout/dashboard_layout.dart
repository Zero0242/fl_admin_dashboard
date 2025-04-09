import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widgets.dart';

class DashboardLayout extends ConsumerWidget {
  const DashboardLayout({super.key, required this.shell});
  static const String path = '/dashboard';
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffedf1f2),
      drawer: Sidebar(),
      body: Row(
        children: <Widget>[
          if (size.width > 700) Sidebar(),
          Expanded(
            child: Column(
              children: <Widget>[
                const NavBar(),
                Expanded(child: shell),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
