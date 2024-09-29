import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/features/auth/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import 'auth_service_provider.dart';

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final service = ref.read(authServiceProvider);

  return AuthStateNotifier(service: service);
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier({
    required this.service,
  }) : super(AuthState()) {
    _checkLogin();
  }
  final AuthService service;
  GetStorage get storage => GetStorage();

  final _logger = const Logger('AuthStateProvider');

  void _checkLogin() async {
    _logger.log('Verificando login');
    final result = await service.checkLogin();
    if (result == null) {
      state = state.copyWith(status: AuthStatus.notauthenticated);
    } else {
      await storage.write(StorageKeys.token, result.$2);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        usuario: result.$1,
      );
    }
  }

  void login(String email, String password) async {
    final result = await service.login({"correo": email, "password": password});
    if (result == null) return;
    await storage.write(StorageKeys.token, result.$2);
    state = state.copyWith(
      status: AuthStatus.authenticated,
      usuario: result.$1,
    );
  }

  void register({
    required String email,
    required String password,
    required String fullname,
  }) async {
    final result = await service
        .register({"correo": email, "password": password, "nombre": fullname});
    if (result == null) return;
    await storage.write(StorageKeys.token, result.$2);
    state = state.copyWith(
      status: AuthStatus.authenticated,
      usuario: result.$1,
    );
  }

  void logout() async {
    state = state.copyWith(status: AuthStatus.notauthenticated, usuario: null);
    await storage.remove(StorageKeys.token);
  }
}

class AuthState {
  AuthState({
    this.usuario,
    this.status = AuthStatus.checking,
  });

  final Usuario? usuario;
  final AuthStatus status;

  AuthState copyWith({
    Usuario? usuario,
    AuthStatus? status,
  }) {
    return AuthState(
      usuario: usuario,
      status: status ?? this.status,
    );
  }

  bool get isChecking {
    return status == AuthStatus.checking;
  }
}
