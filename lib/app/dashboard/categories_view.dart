import 'package:fl_admin_dashboard/presentation/dashboard/dashboard.dart';
import 'package:fl_admin_dashboard/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesView extends ConsumerWidget {
  const CategoriesView({super.key});
  static const String route = 'categories';
  static const String fullRoute = '${DashboardLayout.path}/$route';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesNotifierProvider).value ?? [];
    final tableState = ref.watch(categoriesTableStateProvider);
    final tableNotifier = ref.read(categoriesTableStateProvider.notifier);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        Text('Vista Categoria', style: CustomLabels.h1),
        const SizedBox(height: 10),
        PaginatedDataTable(
          header: const Center(
            child: Text(
              'Tabla de las categorias',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          columns: <DataColumn>[
            DataColumn(label: Text('ID')),
            DataColumn(
              label: Text('Categoria'),
              onSort: (columnIndex, _) {
                tableNotifier.sortColumn(
                  columnIndex,
                  (category) => category.nombre,
                );
              },
            ),
            DataColumn(label: Text('Usuario')),
            DataColumn(label: Text('Acciones')),
          ],
          source: CategoriesSource(categories, context),
          rowsPerPage: tableState.rowsPerPage,
          onRowsPerPageChanged: (value) {
            tableNotifier.changeRowsPerPage(value ?? 10);
          },
          actions: [
            CustomIconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => const CategoryModal(),
                );
              },
              text: 'Crear',
              icon: Icons.add_outlined,
            ),
          ],
        ),
      ],
    );
  }
}
