import 'package:admin_dashboard/helpers/cafe_api.dart';
import 'package:admin_dashboard/models/category.dart';
import 'package:flutter/material.dart';

import '../models/http/categories_response.dart';

class CategoriasProvider extends ChangeNotifier {
  List<Categoria> categorias = [];

  Future getCategories() async {
    final resp = await CafeApi.httpGet(endpoint: '/categorias');
    final categoriesResponse = CategoriesResponse.fromJson(resp);
    categorias.clear();
    categorias = [...categorias, ...categoriesResponse.categorias];
    Future.delayed(
      const Duration(milliseconds: 300),
      () => notifyListeners(),
    );
  }

  Future createCategory(String name) async {
    final data = {'nombre': name};
    try {
      final json = await CafeApi.httpPost(endpoint: '/categorias', data: data);

      final newCategory = Categoria.fromJson(json);

      categorias.add(newCategory);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future updateCategory(String name, String id) async {
    final data = {'nombre': name};
    try {
      await CafeApi.httpPut(endpoint: '/categorias/$id', data: data);

      categorias = categorias.map((cat) {
        if (cat.id != id) return cat;
        cat.nombre = name;

        return cat;
      }).toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future deleteCategory(Categoria cat) async {
    try {
      await CafeApi.httpDelete(endpoint: '/categorias/${cat.id}');
      categorias.remove(cat);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
