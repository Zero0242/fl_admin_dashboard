import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datatables/users_datasource.dart';
import '../labels/custom_labels.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsersProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Text('Users View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: <DataColumn>[
              const DataColumn(label: Text('Avatar')),
              DataColumn(
                label: const Text('Nombre'),
                onSort: (index, _) => provider.sortColumn<String>((user) => user.nombre),
              ),
              DataColumn(
                label: const Text('Email'),
                onSort: (index, _) => provider.sortColumn<String>((user) => user.correo),
              ),
              const DataColumn(label: Text('UID')),
              const DataColumn(label: Text('Acciones')),
            ],
            source: UsersDataSource(provider.users),
          )
        ],
      ),
    );
  }
}
