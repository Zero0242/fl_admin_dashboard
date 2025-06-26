import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/domain/auth/auth.dart';
import 'package:fl_admin_dashboard/domain/dashboard/dashboard.dart';
import 'package:fl_admin_dashboard/helpers/plugins/plugins.dart';

class UsersServiceApi extends UsersService {
  static const Logger _logger = Logger('UsersServiceApi');
  Dio get dashboardApi => locator.get<Dio>();

  @override
  Future<Usuario?> createUsuario(Map<String, dynamic> form) async {
    try {
      final resp = await dashboardApi.post('/api/usuarios');
      final data = resp.data;
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
      final data = resp.data;
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
      final data = resp.data;
      return Usuario.fromMap(data);
    } catch (e) {
      throw Exception('Error en getUsuarioById: $e');
    }
  }

  @override
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await dashboardApi.get('/api/usuarios?limite=100&desde=0');
      final data = resp.data;
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
      final resp = await dashboardApi.put(
        '/api/usuarios/$id',
        data: jsonEncode(form),
      );
      final data = resp.data;
      return Usuario.fromMap(data);
    } catch (e) {
      _logger.error('Error en updateUsuario: $e');
      return null;
    }
  }

  @override
  Future<Usuario?> addAvatar(String id, PlatformFile file) async {
    try {
      final formData = FormData.fromMap({
        'archivo': MultipartFile.fromBytes(file.bytes!, filename: file.name),
      });
      final resp = await dashboardApi.put(
        '/api/uploads/usuarios/$id',
        data: formData,
      );
      final map = resp.data;
      return Usuario.fromMap(map);
    } catch (e) {
      _logger.error('Error en addAvatar $e');
      return null;
    }
  }
}
