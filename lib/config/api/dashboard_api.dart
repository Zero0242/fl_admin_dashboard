import 'package:get_storage/get_storage.dart';

import '../constants/storage_constants.dart';
import '../plugins/http_plugin.dart';

final dashboardApi = HttpPluginLite(
  baseURL: 'http://localhost:8080',
  baseHeaders: {
    "Content-Type": "application/json",
  },
  interceptor: (request) {
    final prefs = GetStorage();
    String? token = prefs.read<String>(StorageKeys.token);
    token ??= '';
    request.headers['x-token'] = 'Bearer $token';
  },
);
