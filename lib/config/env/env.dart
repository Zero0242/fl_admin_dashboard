enum EnvMode { local, development, production }

class Envs {
  // static const _currentEnv = EnvMode.development;

  /// Si es que disponemos del SSL
  static bool get isHttps {
    return getApiUrl().startsWith('https');
  }

  /// URL principal del API
  static String getApiUrl() {
    return "http://localhost:8080";
  }
}
