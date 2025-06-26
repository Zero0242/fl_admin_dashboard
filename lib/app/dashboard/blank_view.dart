import 'package:fl_admin_dashboard/presentation/shared/shared.dart';
import 'package:flutter/material.dart';

import 'dashboard_layout.dart';

class BlankView extends StatelessWidget {
  const BlankView({super.key});
  static const String route = 'blank';
  static const String fullRoute = '${DashboardLayout.path}/$route';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Text('Dashboard View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          const WhiteCard(title: 'Sales Statistics', child: Text('Hola Mundo')),
        ],
      ),
    );
  }
}
