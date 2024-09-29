import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/env_mode.dart';
import '../constants/storage_constants.dart';

const _currentEnv = EnvMode.local;

final dashboardApi = Dio(
  BaseOptions(
    baseUrl: switch (_currentEnv) {
      EnvMode.production => "",
      EnvMode.development => "",
      EnvMode.local =>
        Platform.isAndroid ? 'http://127.0.0.1:8080' : 'http://localhost:8080',
    },
  ),
)..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = SharedPreferencesAsync();
        String? token = await prefs.getString(StorageKeys.token);
        token ??= '';
        options.headers['x-token'] = 'Bearer $token';
      },
    ),
  );
