library;

import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;

/// Tipo para la funcion que interviene el request
typedef InterceptorFunction = FutureOr<void> Function(
  http.BaseRequest request,
);

/// Tipo que envuelve el MultiPartFile de la libreria http
typedef FormFile = http.MultipartFile;

class HttpPluginLite {
  /// Implementacion personalizada del cliente http.
  /// ```dart
  /// final demoApi = HttpPluginLite(
  ///   baseUrl: 'https://algundominio.com',
  ///   baseHeaders: {'Accept': 'application/json'},
  ///   debugMode: true,
  ///   interceptor: (request,endpoint) {
  ///     print(endpoint);
  ///     // Agregar un token a los headers
  ///     request.headers['Authorization'] = 'Bearer mitokensecreto';
  ///   }
  /// );
  /// ```
  HttpPluginLite({
    required this.baseURL,
    this.baseHeaders = const {'Accept': 'application/json'},
    this.debugMode = false,
    this.interceptor,
  })  : _baseClient = _InternalHTTPClient(
          interceptor: interceptor,
          headers: baseHeaders,
          debugMode: debugMode,
        ),
        assert(
          baseURL.startsWith('http'),
          'El url base debe comenzar con http o https',
        );

  final _InternalHTTPClient _baseClient;

  /// Dominio al cual apunta el api, ej: `https://poke.api`
  final String baseURL;

  /// Cabeceras base de cada request,ej: `{'Accept': 'application/json'}`
  final Map<String, String> baseHeaders;

  /// Habilitar mensajes x consolas en cada petición
  final bool debugMode;

  /// Función que intercepta el request antes de ser enviado
  /// ```dart
  /// final demoApi = HttpPluginLite(
  ///   baseUrl: 'https://algundominio.com',
  ///   interceptor: (request,endpoint) {
  ///     print(endpoint);
  ///     // Agregar un token a los headers
  ///     request.headers['Authorization'] = 'Bearer mitokensecreto';
  /// }
  /// ```
  final InterceptorFunction? interceptor;

  /// Crea el url del request
  Uri _generateUri(String path) => Uri.parse(baseURL + path);

  /// Realiza una peticion GET
  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) {
    final url = _generateUri(endpoint);
    return _baseClient.get(url, headers: headers);
  }

  /// Realiza una peticion POST
  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) {
    final url = _generateUri(endpoint);
    return _baseClient.post(
      url,
      body: body,
      headers: headers,
    );
  }

  /// Realiza un POST MultiPartRequest
  Future<http.Response> postForm(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? body,
    List<http.MultipartFile>? files,
  }) {
    return _formRequest(
      endpoint,
      method: 'POST',
      headers: headers,
      body: body,
      files: files,
    );
  }

  /// Realiza un PUT MultiPartRequest
  Future<http.Response> putForm(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? body,
    List<http.MultipartFile>? files,
  }) {
    return _formRequest(
      endpoint,
      method: 'PUT',
      headers: headers,
      body: body,
      files: files,
    );
  }

  /// Realiza una peticion PUT
  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) {
    final url = _generateUri(endpoint);
    return _baseClient.put(
      url,
      body: body,
      headers: headers,
    );
  }

  /// Realiza una peticion DELETE
  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) {
    final url = _generateUri(endpoint);
    return _baseClient.delete(
      url,
      body: body,
      headers: headers,
    );
  }

  /// Implementacion base de MultiPartRequest
  Future<http.Response> _formRequest(
    String endpoint, {
    required String method,
    Map<String, String>? headers,
    Map<String, String>? body,
    List<http.MultipartFile>? files,
  }) async {
    final url = _generateUri(endpoint);
    final request = http.MultipartRequest(method, url);
    if (headers != null) request.headers.addAll(headers);
    if (body != null) request.fields.addAll(body);
    if (files != null) request.files.addAll(files);
    interceptor?.call(request);
    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
  }
}

/// Cliente base, contiene la funcionalidad base del tracker y el interceptor
class _InternalHTTPClient extends http.BaseClient {
  _InternalHTTPClient({
    required this.headers,
    this.interceptor,
    this.debugMode = false,
  });

  final InterceptorFunction? interceptor;
  final Map<String, String> headers;
  final bool debugMode;

  /// Logs para las peticiones http
  void _trackAction(http.StreamedResponse response) {
    if (!debugMode) return;
    log(
      response.buildMessage(),
      name: 'HTTP',
    );
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll(headers);
    await interceptor?.call(request);
    final result = await request.send();
    _trackAction(result);
    return result;
  }
}

extension CheckResponse on http.Response {
  bool get ok => statusCode < 300;
  bool get isRequestError => statusCode >= 400 && statusCode < 500;
  bool get isServerError => statusCode >= 500;
}

extension on http.StreamedResponse {
  bool get ok => statusCode < 300;

  String get method => request?.method ?? 'GET';

  String buildMessage() {
    final DateTime(:hour, :minute, :second) = DateTime.now();

    final format =
        [hour, minute, second].map((e) => '$e'.padLeft(2, '0')).join(':');
    return "[ $format ]: ${method.padRight(5, ' ')}${getIcon()} \n( $statusCode ): ${getFullEndpoint()}";
  }

  String getFullEndpoint() {
    final endpoint = request?.url.path ?? '';
    final query = request?.url.query ?? '';
    if (query.isEmpty) return endpoint;
    return '$endpoint?$query';
  }

  String getIcon() {
    if (ok) return '✨';
    return '🚫';
  }
}
