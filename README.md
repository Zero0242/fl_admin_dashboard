<p align="center">
  <a href="https://flutter.dev/" target="blank">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Google-flutter-logo.png/800px-Google-flutter-logo.png" width="200" alt="App Logo" /></a>
</p>

# Proyecto Admin Web

Dashboard administrativo con riverpod + go_router, curso de [Udemy](https://www.udemy.com/course/flutter-web-fh)

> Creado en Flutter

## DEV

1. Clonar repositorio con `git clone`
2. Instalar los paquetes de Flutter con `flutter pub get`
3. Construir proveedores `dart run build_runner build -d`
4. Ejecutar el proyecto con `flutter run` o con `F5`

## Requisitos

1. Tener instalado Flutter
2. Repositorio del backend [Github](https://github.com/Klerith/RN-Backend-MERN-CAFE)

## Scripts

Algunos scripts que pueden ser utilizados

| Comando                             | Descripcion                      |
| ----------------------------------- | -------------------------------- |
| `flutter pub get`                   | Instala las dependencias         |
| `flutter  build web`                | Crea los assets estaticos de Web |
| `dart fix --apply && dart format .` | Formatea el codigo               |
| `flutter clean`                     | Limpia las dependencias          |

#### Otros Scripts

Otros scripts que pueden usar para fines de desarrollo, (acciones de paquetes)

| Comando                          | Descripcion           |
| -------------------------------- | --------------------- |
| `dart run build_runner build -d` | Construir proveedores |
| `dart run build_runner watch -d` | Construir proveedores |

## Documentacion

Links de librerias utilizadas

- [Flutter]("https://flutter.dev/")
- [Riverpod](https://riverpod.dev/docs/introduction/getting_started)

## GoRouter + Riverpod

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

# Docker

Para generar la imagen `docker build --tag zero0242/flutter_admin_dashboard:latest .`

Con esto montamos los contenidos estaticos en `nginx`
