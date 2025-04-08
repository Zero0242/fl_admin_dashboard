import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/domain/auth/auth.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/auth.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  Auth() {
    WidgetsBinding.instance.addPostFrameCallback((ts) {
      _checkLogin();
    });
  }
  @override
  AuthState build() {
    return AuthState();
  }

  AuthService get _service => LocalAuthService();
  Logger get _logger => const Logger('AuthStateProvider');

  void _checkLogin() async {
    _logger.log('Verificando login');
    final result = await _service.checkLogin();
    if (result == null) {
      state = state.copyWith(status: AuthStatus.notauthenticated);
    } else {
      await StoragePlugin.write(StorageKeys.token, result.$2);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        usuario: result.$1,
      );
    }
  }

  void login(String email, String password) async {
    final result =
        await _service.login({"correo": email, "password": password});
    if (result == null) return;
    await StoragePlugin.write(StorageKeys.token, result.$2);
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
    final result = await _service
        .register({"correo": email, "password": password, "nombre": fullname});
    if (result == null) return;
    await StoragePlugin.write(StorageKeys.token, result.$2);
    state = state.copyWith(
      status: AuthStatus.authenticated,
      usuario: result.$1,
    );
  }

  void logout() async {
    state = state.copyWith(status: AuthStatus.notauthenticated, usuario: null);
    await StoragePlugin.delete(StorageKeys.token);
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
