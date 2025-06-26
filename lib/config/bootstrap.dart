import 'dart:developer';

import 'package:fl_admin_dashboard/config/config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// La simple instancia de get_it, para buscar nuestros singleton y accederlos
GetIt locator = GetIt.instance;

/// Registro de singletons usados por la aplicacion
///
/// El uso más directo de esto es la instancia de la base de datos
///
/// * Inicia los servicios de la aplicación en general
Future<void> bootstrap() async {
  log('Registrando servicios', name: 'GetIt');

  final talker = locator.registerSingleton<Talker>(
    TalkerFlutter.init(
      settings: TalkerSettings(
        enabled: true,
        useConsoleLogs: kDebugMode,
        maxHistoryItems: 1000,
      ),
    ),
  );
  locator.registerLazySingleton(() => DashboardApi.setup());
  FlutterError.onError = (details) {
    talker.error("main_app", details.toStringShort(), details.stack);
    talker.handle(details.exceptionAsString(), details.stack);
  };
}
