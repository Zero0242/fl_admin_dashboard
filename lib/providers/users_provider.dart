import 'package:admin_dashboard/helpers/cafe_api.dart';
import 'package:admin_dashboard/models/http/users_response.dart';
import 'package:flutter/material.dart';

import '../models/usuario_auth.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;

  int? sortColumnIndex;

  UsersProvider() {
    getPaginatedUsers();
  }

  void getPaginatedUsers() async {
    final resp = await CafeApi.httpGet(endpoint: '/usuarios?limite=100&desde=0');
    final usersResp = UsersResponse.fromJson(resp);
    users = [...usersResp.usuarios];
    isLoading = false;

    notifyListeners();
  }

  Future<Usuario?> getUser(String uid) async {
    try {
      final resp = await CafeApi.httpGet(endpoint: '/usuarios/$uid');
      final user = Usuario.fromJson(resp);
      return user;
    } catch (e) {
      return null;
    }
  }

  void sortColumn<T>(Comparable<T> Function(Usuario user) getField) {
    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });
    ascending = !ascending;
    notifyListeners();
  }

  void refreshUser(Usuario newUser) {
    users.removeWhere((user) => user.uid == newUser.uid);
    users.add(newUser);
    notifyListeners();
  }
}
