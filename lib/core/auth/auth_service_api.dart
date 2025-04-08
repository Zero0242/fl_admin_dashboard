import 'dart:convert';

import 'package:fl_admin_dashboard/config/config.dart';

import '../../domain/auth/auth.dart';

class AuthServiceApi extends AuthService {
  final _logger = const Logger('AuthServiceApi');
  @override
  Future<(Usuario, String)?> checkLogin() async {
    try {
      final result = await dashboardApi.get('/api/auth');
      final data = jsonDecode(result.body);
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
        body: json.encode(form),
      );
      final data = jsonDecode(result.body);
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
        body: jsonEncode(form),
      );
      final data = jsonDecode(result.body);
      final usuario = Usuario.fromMap(data['usuario']);
      final token = data['token'] as String;
      return (usuario, token);
    } catch (e) {
      _logger.error('Error en register $e');
      return null;
    }
  }
}
