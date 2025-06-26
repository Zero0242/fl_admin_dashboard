import 'package:fl_admin_dashboard/config/config.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Para imprimir logs personalizados en consola
/// * Con los superpoderes de [flutter_logs](https://pub.dev/packages/flutter_logs)
/// * Con los superpoderes de [talker_flutter](https://pub.dev/packages/talker_flutter)
class Logger {
  /// Crea un logger con timestamp y salto de linea
  const Logger(this.context);

  /// Nombre que tendrá el logger
  final String context;

  Talker get _talker => locator.get<Talker>();

  /// El log común del logger
  void log(Object? value) {
    _talker.info('[ $context ]\n$value');
  }

  /// El log con advertencias
  void warn(Object? value) {
    _talker.warning('[ $context ]\n$value');
  }

  /// El log con errores
  void error(Object? value) {
    _talker.error('[ $context ]\n$value');
  }
}
