import 'package:admin_dashboard/helpers/cafe_api.dart';
import 'package:admin_dashboard/models/category.dart';
import 'package:flutter/material.dart';

import '../models/http/categories_response.dart';

class CategoriasProvider extends ChangeNotifier {
  List<Categoria> categorias = [];

  Future getCategories() async {
    final resp = await CafeApi.httpGet(endpoint: '/categorias');
    final categoriesResponse = CategoriesResponse.fromJson(resp);

    categorias = [...categorias, ...categoriesResponse.categorias];
    Future.delayed(
      const Duration(milliseconds: 300),
      () => notifyListeners(),
    );
  }
}
