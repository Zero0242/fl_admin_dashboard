import 'package:fl_admin_dashboard/core/dashboard/dashboard.dart';
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
    state = AsyncData([result, ...?state.value]);
  }

  void updateCategory(String id, String name) async {
    final service = ref.read(categoriesServiceProvider);
    final result = await service.updateCategoria(id, {'nombre': name});
    if (result == null) return;
    final prev = state.value?.map((e) {
      if (e.id == id) return e.copyWith(nombre: name);
      return e;
    }).toList();
    state = AsyncData([result, ...?prev]);
  }

  void deleteCategory(String id) async {
    final service = ref.read(categoriesServiceProvider);
    final result = await service.deleteCategoria(id);
    if (result == null) return;
    state = AsyncData([...?state.value?.where((e) => e.id != id)]);
  }
}
