import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../datatables/categories_datasource.dart';
import '../buttons/custom_icon_button.dart';
import '../labels/custom_labels.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriasProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          columns: const <DataColumn>[
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Categoria')),
            DataColumn(label: Text('Usuario')),
            DataColumn(label: Text('Acciones')),
          ],
          source: CategoriesSource(),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (value) {
            setState(() => _rowsPerPage = value ?? 10);
          },
          actions: [
            CustomIconButton(
              onPressed: () {},
              text: 'Crear',
              icon: Icons.add_outlined,
            ),
          ],
        ),
      ],
    );
  }
}
