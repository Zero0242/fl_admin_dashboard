import 'package:flutter/material.dart' show PaginatedDataTable;

class TableState {
  const TableState({
    this.ascendingColumn,
    this.isAscending = false,
    this.rowsPerPage = PaginatedDataTable.defaultRowsPerPage,
  });

  final int? ascendingColumn;
  final bool isAscending;
  final int rowsPerPage;

  TableState copyWith({
    int? ascendingColumn,
    bool? isAscending,
    int? rowsPerPage,
  }) {
    return TableState(
      ascendingColumn: ascendingColumn ?? this.ascendingColumn,
      isAscending: isAscending ?? this.isAscending,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
    );
  }
}
