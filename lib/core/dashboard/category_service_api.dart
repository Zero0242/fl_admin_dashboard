import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/domain/dashboard/dashboard.dart';
import 'package:fl_admin_dashboard/helpers/plugins/plugins.dart';

class CategoryServiceApi extends CategoriesService {
  static const Logger _logger = Logger('CategoryServiceApi');
  Dio get dashboardApi => locator.get<Dio>();

  @override
  Future<Categoria?> createCategoria(Map<String, dynamic> form) async {
    try {
      final resp = await dashboardApi.post(
        '/api/categorias',
        data: jsonEncode(form),
      );
      final data = resp.data;
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
      final data = resp.data;
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
      final data = resp.data;
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
        data: jsonEncode(form),
      );
      final data = resp.data;
      return Categoria.fromJson(data);
    } catch (e) {
      _logger.error('Error al updateCategoria: $e');
      return null;
    }
  }
}
