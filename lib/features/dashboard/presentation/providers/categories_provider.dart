import 'package:fl_admin_dashboard/config/plugins/logger_pluggin.dart';
import 'package:fl_admin_dashboard/features/dashboard/infraestructure/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/domain.dart';

part 'categories_provider.g.dart';

@riverpod
CategoriesService categoriesService(Ref ref) {
  return CategoryServiceApi();
}

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  CategoriesNotifier() {
    Future.microtask(_initialLoad);
  }
  @override
  List<Categoria> build() {
    return [];
  }

  Logger get _logger => const Logger('CategoriesNotifier');

  void _initialLoad() async {
    _logger.log('Loading...');
    final service = ref.read(categoriesServiceProvider);
    state = await service.getCategorias();
  }

  void addCategory(String name) async {
    final service = ref.read(categoriesServiceProvider);
    final result = await service.createCategoria({'nombre': name});
    if (result == null) return;
    state = [result, ...state];
  }

  void updateCategory(String id, String name) async {
    final service = ref.read(categoriesServiceProvider);
    final result = await service.updateCategoria(id, {'nombre': name});
    if (result == null) return;
    state = state.map((e) {
      if (e.id == id) return e.copyWith(nombre: name);
      return e;
    }).toList();
  }

  void deleteCategory(String id) async {
    final service = ref.read(categoriesServiceProvider);
    final result = await service.deleteCategoria(id);
    if (result == null) return;
    state = state.where((e) => e.id != id).toList();
  }
}
