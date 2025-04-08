import '../constants/storage_constants.dart';
import '../plugins/http_plugin.dart';
import '../plugins/storage_plugin.dart';

final dashboardApi = HttpPluginLite(
  baseURL: 'http://localhost:8080',
  baseHeaders: {
    "Content-Type": "application/json",
  },
  interceptor: (request) async {
    String? token = await StoragePlugin.read(StorageKeys.token);
    token ??= '';
    request.headers['x-token'] = token;
  },
);
