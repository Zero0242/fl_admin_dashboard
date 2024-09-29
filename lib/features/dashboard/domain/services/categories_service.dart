import '../models/categoria.dart';

abstract class CategoriesService {
  Future<List<Categoria>> getCategorias();
  Future<Categoria?> createCategoria(Map<String, dynamic> form);
  Future<Categoria?> updateCategoria(String id, Map<String, dynamic> form);
  Future<Categoria?> deleteCategoria(String id);
}
