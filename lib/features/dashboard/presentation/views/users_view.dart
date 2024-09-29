import 'package:fl_admin_dashboard/features/shared/shared.dart';
import 'package:flutter/material.dart';

import '../layout/dashboard_layout.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});
  static const String route = 'users';
  static const String fullRoute = '${DashboardLayout.path}/$route';

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<UsersProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Text('Users View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          // PaginatedDataTable(
          //   sortAscending: provider.ascending,
          //   sortColumnIndex: provider.sortColumnIndex,
          //   columns: <DataColumn>[
          //     const DataColumn(label: Text('Avatar')),
          //     DataColumn(
          //       label: const Text('Nombre'),
          //       onSort: (index, _) {
          //         provider.sortColumnIndex = index;
          //         provider.sortColumn<String>((user) => user.nombre);
          //       },
          //     ),
          //     DataColumn(
          //       label: const Text('Email'),
          //       onSort: (index, _) {
          //         provider.sortColumnIndex = index;
          //         provider.sortColumn<String>((user) => user.correo);
          //       },
          //     ),
          //     const DataColumn(label: Text('UID')),
          //     const DataColumn(label: Text('Acciones')),
          //   ],
          //   source: UsersDataSource(provider.users),
          // )
        ],
      ),
    );
  }
}
