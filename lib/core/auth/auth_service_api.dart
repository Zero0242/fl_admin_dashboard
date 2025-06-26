import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_admin_dashboard/config/bootstrap.dart';
import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/domain/auth/auth.dart';
import 'package:fl_admin_dashboard/helpers/plugins/plugins.dart';

class AuthServiceApi extends AuthService {
  static const _logger = Logger('AuthServiceApi');
  Dio get dashboardApi => locator.get<Dio>();
  @override
  Future<(Usuario, String)?> checkLogin() async {
    try {
      final result = await dashboardApi.get('/api/auth');
      final data = result.data;
      final usuario = Usuario.fromMap(data['usuario']);
      final token = data['token'] as String;
      return (usuario, token);
    } catch (e) {
      _logger.error('Error en checkLogin $e');
      return null;
    }
  }

  @override
  Future<(Usuario, String)?> login(Map<String, String> form) async {
    try {
      final result = await dashboardApi.post(
        '/api/auth/login',
        data: json.encode(form),
      );
      final data = result.data;
      final usuario = Usuario.fromMap(data['usuario']);
      final token = data['token'] as String;
      return (usuario, token);
    } catch (e) {
      _logger.error('Error en login $e');
      return null;
    }
  }

  @override
  Future<(Usuario, String)?> register(Map<String, String> form) async {
    try {
      final result = await dashboardApi.post(
        '/api/usuarios',
        data: jsonEncode(form),
      );
      final data = result.data;
      final usuario = Usuario.fromMap(data['usuario']);
      final token = data['token'] as String;
      return (usuario, token);
    } catch (e) {
      _logger.error('Error en register $e');
      return null;
    }
  }
}
