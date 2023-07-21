import 'package:flutter/material.dart';

class CategoriesSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: const <DataCell>[
        DataCell(FlutterLogo()),
        DataCell(FlutterLogo()),
        DataCell(FlutterLogo()),
        DataCell(FlutterLogo()),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
