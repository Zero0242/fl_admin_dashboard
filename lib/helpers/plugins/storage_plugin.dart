import 'package:get_storage/get_storage.dart';

/// Interfaz de un plugin para guardar datos
class StoragePlugin {
  static late final GetStorage _store;

  /// Alguna inicialización que requiera el paquete
  static Future<void> init() async {
    await GetStorage.init();
    _store = GetStorage();
  }

  /// Guardar/Actualizar valor
  static Future<void> write(String key, String value) {
    return _store.write(key, value);
  }

  /// Lectura de valor
  static Future<String?> read(String key) {
    final result = _store.read<String>(key);
    return Future.value(result);
  }

  /// Eliminacion de valor
  static Future<bool> delete(String key) async {
    await _store.remove(key);
    final result = await read(key);
    return result == null;
  }
}
