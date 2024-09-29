import 'package:fl_admin_dashboard/features/auth/presentation/providers/providers.dart';
import 'package:fl_admin_dashboard/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout/dashboard_layout.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});
  static const String route = 'index';
  static const String fullRoute = '${DashboardLayout.path}/$route';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authStateProvider).usuario;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Text('Dashboard View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          WhiteCard(
            title: authUser?.nombre,
            child: Text(authUser?.correo ?? ''),
          ),
        ],
      ),
    );
  }
}
