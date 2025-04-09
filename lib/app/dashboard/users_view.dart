import 'package:fl_admin_dashboard/presentation/dashboard/dashboard.dart';
import 'package:fl_admin_dashboard/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersView extends ConsumerWidget {
  const UsersView({super.key});
  static const String route = 'users';
  static const String fullRoute = '${DashboardLayout.path}/$route';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersNotifierProvider);
    final tableState = ref.watch(currentUserTableStateProvider);
    final tableNotifier = ref.read(currentUserTableStateProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Text('Users View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            rowsPerPage: tableState.rowsPerPage,
            onRowsPerPageChanged: (value) {
              final updated = value ?? tableState.rowsPerPage;
              tableNotifier.changeRowsPerPage(updated);
            },
            sortAscending: tableState.isAscending,
            sortColumnIndex: tableState.ascendingColumn,
            columns: <DataColumn>[
              const DataColumn(label: Text('Avatar')),
              DataColumn(
                label: const Text('Nombre'),
                onSort: (index, _) {
                  tableNotifier.sortColumn(index, (user) => user.nombre);
                },
              ),
              DataColumn(
                label: const Text('Email'),
                onSort: (index, _) {
                  tableNotifier.sortColumn(index, (user) => user.correo);
                },
              ),
              const DataColumn(label: Text('UID')),
              const DataColumn(label: Text('Acciones')),
            ],
            source: UsersDataSource(
              usersAsync.value ?? [],
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
