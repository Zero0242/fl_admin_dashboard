import 'package:dio/dio.dart';
import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/helpers/plugins/plugins.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await StoragePlugin.read(StorageKeys.token);
    token ??= '';
    options.headers['x-token'] = token;
    return handler.next(options);
  }
}

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    int retryCount = 0;

    if (_shouldRetry(err)) {
      while (retryCount < maxRetries) {
        try {
          retryCount++;

          await Future.delayed(retryDelay * retryCount);

          final response = await dio.request(
            err.requestOptions.path,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );

          return handler.resolve(response);
        } on DioException catch (e) {
          if (retryCount >= maxRetries) {
            return handler.next(e);
          }
        }
      }
    }

    return handler.next(err);
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError;
  }
}
