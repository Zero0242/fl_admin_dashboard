import 'package:admin_dashboard/models/category.dart';
import 'package:flutter/material.dart';

class CategoriesSource extends DataTableSource {
  CategoriesSource(this.categorias, this.context);
  final List<Categoria> categorias;
  final BuildContext context;

  @override
  DataRow? getRow(int index) {
    final categoria = categorias[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(categoria.id)),
        DataCell(Text(categoria.nombre)),
        DataCell(Text(categoria.usuario.nombre)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  print('editando: $categoria');
                },
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () {
                  final dialog = AlertDialog(
                    title: const Text('¿Está seguro de borrarlo?'),
                    content: Text('¿Borrar definitivamente $categoria?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Si, borrar'))
                    ],
                  );
                  showDialog(context: context, builder: (_) => dialog);
                },
                icon: Icon(
                  Icons.delete_outlined,
                  color: Colors.red.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categorias.length;

  @override
  int get selectedRowCount => 0;
}
