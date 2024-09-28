import 'package:shared_preferences/shared_preferences.dart';

abstract class IStoragePlugin {
  /// Inicial el store, sin esto no funciona el store generalmente
  Future<void> configure();
  // Lectura
  /// Guarda un String
  Future<String?> getString(String key);

  /// Guarda un Int
  Future<int?> getInt(String key);

  /// Guarda un Double
  Future<double?> getDouble(String key);

  /// Guarda un Booleano
  Future<bool?> getBoolean(String key);
  // Escritura
  /// Lectura del String
  Future<void> setString(String key, String value);

  /// Lectura del Int
  Future<void> setInt(String key, int value);

  /// Lectura del Double
  Future<void> setDouble(String key, double value);

  /// Lectura del Booleano
  Future<void> setBoolean(String key, bool value);
  // Eliminar
  /// Remueve un valor
  Future<void> remove(String key);
}

/// Implementacion de shared_preferences
class SharedPreferencesPlugin implements IStoragePlugin {
  SharedPreferences? _preferences;

  @override
  Future<void> configure() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<String?> getString(String key) {
    final value = _preferences?.getString(key);
    return Future.value(value);
  }

  @override
  Future<bool?> getBoolean(String key) {
    return Future.value(_preferences?.getBool(key));
  }

  @override
  Future<double?> getDouble(String key) {
    return Future.value(_preferences?.getDouble(key));
  }

  @override
  Future<int?> getInt(String key) {
    return Future.value(_preferences?.getInt(key));
  }

  @override
  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  @override
  Future<void> setBoolean(String key, bool value) async {
    _preferences?.setBool(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    _preferences?.setDouble(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    _preferences?.setInt(key, value);
  }

  @override
  Future<void> setString(String key, String value) async {
    _preferences?.setString(key, value);
  }
}
