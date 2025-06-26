import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../env/env.dart';
import 'interceptors.dart';

class DashboardApi {
  static Dio setup() {
    final instance = Dio(
      BaseOptions(
        baseUrl: Envs.getApiUrl(),
        headers: {"Content-Type": "application/json"},
      ),
    );
    instance.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: false,
          printResponseHeaders: false,
          printResponseMessage: true,
        ),
      ),
    );
    instance.interceptors.add(RetryInterceptor(dio: instance, maxRetries: 2));
    instance.interceptors.add(AppInterceptor());

    return instance;
  }
}

extension HttpStats on Response {
  bool get ok {
    return statusCode.toString().startsWith('2');
  }
}
