import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({super.key, required this.child});
  static const String path = '/auth';
  final Widget child;

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        controller: controller,
        thumbVisibility: true,
        child: ListView(
          controller: controller,
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            if (size.width > 1000)
              _DesktopComponent(child: widget.child)
            else
              _MobileComponent(child: widget.child),
            const LinkBar(),
          ],
        ),
      ),
    );
  }
}

class _DesktopComponent extends StatelessWidget {
  const _DesktopComponent({required this.child});

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
          const Expanded(child: AuthBackground()),
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const AuthHeader(),
                const SizedBox(height: 50),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileComponent extends StatelessWidget {
  const _MobileComponent({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          const AuthHeader(),
          SizedBox(
            height: 420,
            width: double.infinity,
            child: child,
          ),
          const SizedBox(
            width: double.infinity,
            height: 400,
            child: AuthBackground(),
          ),
        ],
      ),
    );
  }
}
