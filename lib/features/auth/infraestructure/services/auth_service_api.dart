import 'dart:convert';

import 'package:fl_admin_dashboard/config/config.dart';

import '../../domain/domain.dart';

class AuthServiceApi extends AuthService {
  final _logger = const Logger('AuthServiceApi');
  @override
  Future<(Usuario, String)?> checkLogin() async {
    try {
      final result = await dashboardApi.get('/api/auth');
      final usuario = Usuario.fromMap(result.data['usuario']);
      final token = result.data['token'] as String;
      return (usuario, token);
    } catch (e) {
      _logger.error('Error en checkLogin $e');
      return null;
    }
  }

  @override
  Future<(Usuario, String)?> login(Map<String, String> form) async {
    try {
      final result = await dashboardApi.get(
        '/api/auth/login',
        data: json.encode(form),
      );
      final usuario = Usuario.fromMap(result.data['usuario']);
      final token = result.data['token'] as String;
      return (usuario, token);
    } catch (e) {
      _logger.error('Error en login $e');
      return null;
    }
  }

  @override
  Future<(Usuario, String)?> register(Map<String, String> form) async {
    try {
      final result = await dashboardApi.get(
        '/api/usuarios',
        data: form,
      );
      final usuario = Usuario.fromMap(result.data['usuario']);
      final token = result.data['token'] as String;
      return (usuario, token);
    } catch (e) {
      _logger.error('Error en register $e');
      return null;
    }
  }
}