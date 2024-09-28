import 'dart:developer' as d;

import 'package:flutter/foundation.dart';

/// Para imprimir logs personalizados en consola
class Logger {
  /// Crea un logger con timestamp y salto de linea
  const Logger(this.context, {this.active = kDebugMode});

  /// Emoji de advertencia
  static const String _warningEmoji = "!";

  /// Emoji de error
  static const String _errorEmoji = "X";

  /// Emoji de exito
  static const String _sparkleEmoji = "✨";

  /// Nombre que tendrá el logger
  final String context;

  /// Para activar o desactivar el logger
  final bool active;

  /// El log con errores
  void error(Object? value) {
    _internalLogger(value, _errorEmoji);
  }

  /// El log común del logger
  void log(Object? value) {
    _internalLogger(value, '');
  }

  /// El log en modo exito
  void success(Object? value) {
    _internalLogger(value, _sparkleEmoji);
  }

  /// El log con advertencias
  void warn(Object? value) {
    _internalLogger(value, _warningEmoji);
  }

  /// Utilidad para extraer la hora actual y formateada
  String _getTime() {
    final DateTime(:hour, :minute, :second) = DateTime.now();
    final String timeStamp = [
      '$hour'.padLeft(2, '0'),
      '$minute'.padLeft(2, '0'),
      '$second'.padLeft(2, '0'),
    ].join(':');
    return timeStamp;
  }

  void _internalLogger(Object? value, String simbol) {
    if (!active) return;
    simbol = simbol.split('').firstOrNull ?? '';

    d.log('\t( ${_getTime()} ): $simbol\t${value.toString()}', name: context);
  }
}
