import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/domain/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/auth.dart';

part 'auth_provider.g.dart';

@riverpod
FutureOr<AuthState> _authAsync(Ref ref) async {
  final result = await AuthServiceApi().checkLogin();
  if (result == null) {
    return AuthState(status: AuthStatus.notauthenticated);
  } else {
    await StoragePlugin.write(StorageKeys.token, result.$2);
    return AuthState(
      status: AuthStatus.authenticated,
      usuario: result.$1,
    );
  }
}

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    final session = ref.watch(_authAsyncProvider).value ?? AuthState();
    return session;
  }

  AuthService get _service => AuthServiceApi();

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
    await StoragePlugin.delete(StorageKeys.token);
    ref.invalidate(_authAsyncProvider);
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
