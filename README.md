# Flutter Dashboard

Dashboard administrativo con riverpod + go_router

## Dev

1. Clonar repositorio
2. Instalar dependencias `flutter pub get`
3. Activar code generator
   - `dart run build_runner build`: para generar y ejecutar
   - `dart run build_runner watch`: para escribir proveedores de riverpod
4. Ejecutar proyecto con F5

# Riverpod

Instalacion de riverpod con code generation segun la [documentacion](https://riverpod.dev/docs/introduction/getting_started)

- Instalaciones

```bash
flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add dev:riverpod_generator
flutter pub add dev:build_runner
flutter pub add dev:custom_lint
flutter pub add dev:riverpod_lint
```

- Code Generator

```bash
dart run build_runner watch
```

# GoRouter + Riverpod

Se puede aplicar un ValueChanged como el refreshable para el `GoRouter`

```dart
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  /**
   * Esta seccion es donde reemplazamos el changenotifier, para poder usar un valuenotifier
   * para refrescar el router, solo si cambiamos el status actual
   */
  final authListener = ValueNotifier<AuthStatus>(AuthStatus.checking);
  ref.listen(authProvider.select((val) => val.status), (prev, next) {
    authListener.value = next;
  });
  /*  */
  return GoRouter(
   refreshListenable: authListener,
   ...resto de la config
  );
}
```

## NOTAS

La evaluacion de `Platform.isAndroid` causa errores en web **NO OLVIDAR C:**
