import 'dart:convert';

import 'package:fl_admin_dashboard/config/config.dart';

import '../../domain/dashboard/dashboard.dart';

class CategoryServiceApi extends CategoriesService {
  final Logger _logger = const Logger('CategoryServiceApi');
  @override
  Future<Categoria?> createCategoria(Map<String, dynamic> form) async {
    try {
      final resp = await dashboardApi.post(
        '/api/categorias',
        body: jsonEncode(form),
      );
      final data = jsonDecode(resp.body);
      return Categoria.fromJson(data);
    } catch (e) {
      _logger.error('Error al createCategoria: $e');
      return null;
    }
  }

  @override
  Future<Categoria?> deleteCategoria(String id) async {
    try {
      final resp = await dashboardApi.delete('/api/categorias/$id');
      final data = jsonDecode(resp.body);
      return Categoria.fromJson(data);
    } catch (e) {
      _logger.error('Error al deleteCategoria: $e');
      return null;
    }
  }

  @override
  Future<List<Categoria>> getCategorias() async {
    try {
      final resp = await dashboardApi.get('/api/categorias');
      final data = jsonDecode(resp.body);
      final values = data['categorias'] as List;
      return values.map((e) => Categoria.fromJson(e)).toList();
    } catch (e) {
      _logger.error('Error al getCategorias: $e');
      return [];
    }
  }

  @override
  Future<Categoria?> updateCategoria(
    String id,
    Map<String, dynamic> form,
  ) async {
    try {
      final resp = await dashboardApi.put(
        '/api/categorias/$id',
        body: jsonEncode(form),
      );
      final data = jsonDecode(resp.body);
      return Categoria.fromJson(data);
    } catch (e) {
      _logger.error('Error al updateCategoria: $e');
      return null;
    }
  }
}
