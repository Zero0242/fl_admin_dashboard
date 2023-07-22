import 'package:admin_dashboard/helpers/cafe_api.dart';
import 'package:admin_dashboard/models/http/auth_response.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:flutter/material.dart';

import '../models/usuario_auth.dart';

enum AuthStatus { notLogged, authenticated, checking }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }

  void login(String email, String password) {
    final data = {
      'correo': email,
      'password': password,
    };
    CafeApi.httpPost(endpoint: '/auth/login', data: data).then((json) {
      final authResponse = AuthResponse.fromJson(json);
      user = authResponse.usuario;
      _token = authResponse.token;
      LocalStorage.prefs.setString('token', _token!);
      authStatus = AuthStatus.authenticated;
      CafeApi.setupDio();
      notifyListeners();
      NavigationService.navigateTo(Flurorouter.dashboardRoute);
    }).catchError((e) {
      NotificationService.showSnackBarError('Hubo un error: $e');
    });
  }

  void register({required String email, required String password, required String name}) {
    final data = {
      'nombre': name,
      'correo': email,
      'password': password,
    };

    CafeApi.httpPost(endpoint: '/usuarios', data: data).then((json) {
      final authResponse = AuthResponse.fromJson(json);
      user = authResponse.usuario;
      _token = authResponse.token;
      LocalStorage.prefs.setString('token', _token!);
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      NavigationService.navigateTo(Flurorouter.dashboardRoute);
    }).catchError((e) {
      NotificationService.showSnackBarError('Hubo un error: $e');
    });
  }

  Future<bool> isAuthenticated() async {
    final myToken = LocalStorage.prefs.getString('token');
    if (myToken == null) {
      authStatus = AuthStatus.notLogged;
      notifyListeners();
      return false;
    }

    try {
      final resp = await CafeApi.httpGet(endpoint: '/auth');
      final authResponse = AuthResponse.fromJson(resp);
      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      notifyListeners();
      return true;
    } catch (e) {
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return false;
    }
  }

  void logout() async {
    await LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notLogged;
    notifyListeners();
    NavigationService.navigateTo(Flurorouter.loginRoute);
  }
}
