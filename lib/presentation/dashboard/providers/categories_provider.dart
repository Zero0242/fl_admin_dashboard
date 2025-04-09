import 'package:fl_admin_dashboard/core/dashboard/dashboard.dart';
import 'package:fl_admin_dashboard/domain/common/common.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/dashboard/dashboard.dart';

part 'categories_provider.g.dart';

@riverpod
CategoriesService categoriesService(Ref ref) {
  return CategoryServiceApi();
}

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  FutureOr<List<Categoria>> build() {
    final service = ref.read(categoriesServiceProvider);
    return service.getCategorias();
  }

  void addCategory(String name) async {
    final service = ref.read(categoriesServiceProvider);
    final result = await service.createCategoria({'nombre': name});
    if (result == null) return;
    final previous = await future;
    state = AsyncData([result, ...previous]);
  }

  void updateCategory(String id, String name) async {
    final service = ref.read(categoriesServiceProvider);
    final result = await service.updateCategoria(id, {'nombre': name});
    if (result == null) return;
    final previous = await future;
    final updated = previous.map((e) {
      if (e.id == id) return e.copyWith(nombre: name);
      return e;
    }).toList();
    state = AsyncData(updated);
  }

  void deleteCategory(String id) async {
    final service = ref.read(categoriesServiceProvider);
    final result = await service.deleteCategoria(id);
    if (result == null) return;
    final previous = await future;
    state = AsyncData([...previous.where((e) => e.id != id)]);
  }
}

@riverpod
class CategoriesTableState extends _$CategoriesTableState {
  @override
  TableState build() {
    return const TableState();
  }

  void sortColumn<T>(
    int columnIndex,
    Comparable<T> Function(Categoria category) getField,
  ) async {
    final categories = await ref.read(categoriesNotifierProvider.future);
    categories.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return state.isAscending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    state = state.copyWith(
      ascendingColumn: columnIndex,
      isAscending: !state.isAscending,
    );
  }

  void changeRowsPerPage(int value) {
    state = state.copyWith(rowsPerPage: value);
  }
}
