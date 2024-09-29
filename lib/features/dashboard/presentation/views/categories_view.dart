import 'package:fl_admin_dashboard/features/shared/shared.dart';
import 'package:flutter/material.dart';

import '../layout/dashboard_layout.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});
  static const String route = 'categories';
  static const String fullRoute = '${DashboardLayout.path}/$route';

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    // Provider.of<CategoriasProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<CategoriasProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Text('Vista Categoria', style: CustomLabels.h1),
          const SizedBox(height: 10),
          // PaginatedDataTable(
          //   header: const Center(
          //     child: Text(
          //       'Tabla de las categorias',
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          //   columns: const <DataColumn>[
          //     DataColumn(label: Text('ID')),
          //     DataColumn(label: Text('Categoria')),
          //     DataColumn(label: Text('Usuario')),
          //     DataColumn(label: Text('Acciones')),
          //   ],
          //   source: CategoriesSource(provider.categorias, context),
          //   rowsPerPage: _rowsPerPage,
          //   onRowsPerPageChanged: (value) {
          //     setState(() => _rowsPerPage = value ?? 10);
          //   },
          //   actions: [
          //     CustomIconButton(
          //       onPressed: () {
          //         showModalBottomSheet(
          //           backgroundColor: Colors.transparent,
          //           context: context,
          //           builder: (_) => const CategoryModal(),
          //         );
          //       },
          //       text: 'Crear',
          //       icon: Icons.add_outlined,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
