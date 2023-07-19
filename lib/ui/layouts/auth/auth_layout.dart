import 'package:admin_dashboard/ui/buttons/links_navbar.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/background_app.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/custom_titles.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final page = PageController();

    return Scaffold(
      body: Scrollbar(
        controller: page,
        thumbVisibility: true,
        child: ListView(
          controller: page,
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            // desktop
            // mobile
            // links
            if (size.width > 1000) _DesktopBody(child) else _MobileBody(child),
            const LinkBar()
          ],
        ),
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          const CustomTitle(),
          SizedBox(
            height: 420,
            width: double.infinity,
            child: child,
          ),
          const SizedBox(
            width: double.infinity,
            height: 400,
            child: BackgroundApp(),
          )
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height - kBottomNavigationBarHeight,
      width: size.width,
      color: Colors.red,
      child: Row(
        children: <Widget>[
          const Expanded(
            child: BackgroundApp(),
          ),
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const CustomTitle(),
                const SizedBox(height: 50),
                Expanded(child: child)
              ],
            ),
          )
        ],
      ),
    );
  }
}
