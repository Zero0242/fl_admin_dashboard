import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {
  static const String _apiUrl = 'http://localhost:8080/api';
  static Uri generateRoute({required String endpoint}) => Uri.http(_apiUrl, endpoint);

  static final Dio _dio = Dio();

  static void setupDio() {
    _dio.options.baseUrl = _apiUrl;
    _dio.options.headers = {'x-token': LocalStorage.prefs.getString('token') ?? ''};
  }

  static Future httpGet({required String endpoint}) async {
    try {
      final resp = await _dio.get(endpoint);
      return resp.data;
    } catch (e) {
      log(e.toString(), name: endpoint);
    }
  }

  static Future httpPost({required String endpoint, Map<String, dynamic>? data}) async {
    final formData = FormData.fromMap(data ?? {});
    try {
      final resp = await _dio.post(endpoint, data: formData);
      return resp.data;
    } catch (e) {
      log(e.toString(), name: endpoint);
    }
  }

  static Future httpPut({required String endpoint, Map<String, dynamic>? data}) async {
    final formData = FormData.fromMap(data ?? {});
    try {
      final resp = await _dio.put(endpoint, data: formData);
      return resp.data;
    } catch (e) {
      log(e.toString(), name: endpoint);
    }
  }

  static Future httpDelete({required String endpoint, Map<String, dynamic>? data}) async {
    final formData = FormData.fromMap(data ?? {});
    try {
      final resp = await _dio.delete(endpoint, data: formData);
      return resp.data;
    } catch (e) {
      log(e.toString(), name: endpoint);
    }
  }

  static Future uploadFile({required String endpoint, required Uint8List file}) async {
    final formData = FormData.fromMap({
      'archivo': MultipartFile.fromBytes(file),
    });
    try {
      final resp = await _dio.put(endpoint, data: formData);
      return resp.data;
    } catch (e) {
      log(e.toString(), name: endpoint);
    }
  }
}
