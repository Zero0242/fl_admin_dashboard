import 'dart:convert';

import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/features/auth/auth.dart';

import '../../domain/domain.dart';

class UsersServiceApi extends UsersService {
  final Logger _logger = const Logger('UsersServiceApi');

  @override
  Future<Usuario?> createUsuario(Map<String, dynamic> form) async {
    try {
      final resp = await dashboardApi.post('/api/usuarios');
      final data = jsonDecode(resp.body);
      return Usuario.fromMap(data);
    } catch (e) {
      _logger.error('Error en createUsuario: $e');
      return null;
    }
  }

  @override
  Future<Usuario?> deleteUsuario(String id) async {
    try {
      final resp = await dashboardApi.delete('/api/usuarios/$id');
      final data = jsonDecode(resp.body);
      return Usuario.fromMap(data);
    } catch (e) {
      _logger.error('Error en deleteUsuario: $e');
      return null;
    }
  }

  @override
  Future<Usuario> getUsuarioById(String id) async {
    try {
      final resp = await dashboardApi.get('/api/usuarios/$id');
      final data = jsonDecode(resp.body);
      return Usuario.fromMap(data);
    } catch (e) {
      throw Exception('Error en getUsuarioById: $e');
    }
  }

  @override
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await dashboardApi.get('/api/usuarios?limite=100&desde=0');
      final data = jsonDecode(resp.body);
      final values = data['usuarios'] as List;
      return values.map((e) => Usuario.fromMap(e)).toList();
    } catch (e) {
      _logger.error('Error en getUsuarios: $e');
      return [];
    }
  }

  @override
  Future<Usuario?> updateUsuario(String id, Map<String, dynamic> form) async {
    try {
      final resp =
          await dashboardApi.put('/api/usuarios/$id', body: jsonEncode(form));
      final data = jsonDecode(resp.body);
      return Usuario.fromMap(data);
    } catch (e) {
      _logger.error('Error en updateUsuario: $e');
      return null;
    }
  }
}
