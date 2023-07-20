import 'package:admin_dashboard/helpers/cafe_api.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { notLogged, authenticated, checking }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    //Todo peticion http
    _token = 'awesometoken';
    LocalStorage.prefs.setString('token', _token!);
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    NavigationService.navigateTo(Flurorouter.dashboardRoute);
  }

  register({required String email, required String password, required String name}) {
    final data = {
      'nombre': 'Test 16',
      'correo': 'test16@test.com',
      'password': '123456',
    };

    CafeApi.httpPost(endpoint: '/usuarios', data: data).then((json) {
      print(json);
    }).catchError((e) {
      print(e);
    });
    //Todo peticion http
/*     _token = 'awesometoken';
    LocalStorage.prefs.setString('token', _token!);
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    NavigationService.navigateTo(Flurorouter.dashboardRoute); */
  }

  Future<bool> isAuthenticated() async {
    final myToken = LocalStorage.prefs.getString('token');
    if (myToken == null) {
      authStatus = AuthStatus.notLogged;
      notifyListeners();
      return false;
    }

    Future.delayed(const Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  void logout() async {
    await LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notLogged;
    notifyListeners();
    NavigationService.navigateTo(Flurorouter.loginRoute);
  }
}
