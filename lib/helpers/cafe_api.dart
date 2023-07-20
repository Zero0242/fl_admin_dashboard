import 'dart:developer';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {
  static const String _apiUrl = 'http://192.168.1.151:8080/api';
  static Uri generateRoute({required String endpoint}) => Uri.http(_apiUrl, endpoint);

  static final Dio _dio = Dio();

  static void setupDio() {
    _dio.options.baseUrl = _apiUrl;
    // Configurar headers
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
}
