import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/env_mode.dart';
import '../constants/storage_constants.dart';
import '../plugins/logger_pluggin.dart';

const _currentEnv = EnvMode.local;

final dashboardApi = Dio(
  BaseOptions(
    // headers: {
    //   "Content-Type": "application/json",
    // },
    baseUrl: switch (_currentEnv) {
      EnvMode.production => "",
      EnvMode.development => "",
      EnvMode.local =>
        Platform.isAndroid ? 'http://127.0.0.1:8080' : 'http://localhost:8080',
    },
  ),
)..interceptors.addAll([
    LogInterceptor(logPrint: const Logger('HTTP').log),
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = GetStorage();
        String? token = prefs.read<String>(StorageKeys.token);
        token ??= '';
        options.headers['x-token'] = 'Bearer $token';
      },
    ),
  ]);
