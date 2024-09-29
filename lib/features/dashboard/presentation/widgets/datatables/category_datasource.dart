import 'package:fl_admin_dashboard/features/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';

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
        DataCell(Text(categoria.usuario)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => CategoryModal(
                      categoria: categoria,
                    ),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return _DeleteDialog(
                        categoria: categoria,
                      );
                    },
                  );
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

class _DeleteDialog extends ConsumerWidget {
  const _DeleteDialog({required this.categoria});

  final Categoria categoria;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('¿Está seguro de borrarlo?'),
      content: Text('¿Borrar definitivamente ${categoria.nombre}?'),
      actions: <Widget>[
        TextButton(
          onPressed: context.pop,
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () async {
            ref
                .read(categoriesNotifierProvider.notifier)
                .deleteCategory(categoria.id);
            context.pop();
          },
          child: const Text('Si, borrar'),
        ),
      ],
    );
  }
}
