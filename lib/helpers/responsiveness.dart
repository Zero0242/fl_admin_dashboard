import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    super.key,
    required this.desktopWidget,
    this.tabletWidget,
    this.phoneWidget,
  });

  static const int largeScreenSize = 1366;
  static const int mediumScreenSize = 700;

  final Widget Function(BuildContext) desktopWidget;
  final Widget Function(BuildContext)? tabletWidget;
  final Widget Function(BuildContext)? phoneWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width >= largeScreenSize) {
          return Builder(builder: desktopWidget);
        } else if (width >= mediumScreenSize && width < largeScreenSize) {
          return Builder(builder: tabletWidget ?? desktopWidget);
        } else {
          return Builder(builder: phoneWidget ?? tabletWidget ?? desktopWidget);
        }
      },
    );
  }
}
