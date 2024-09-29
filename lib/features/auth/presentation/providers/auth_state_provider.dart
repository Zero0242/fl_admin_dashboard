// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_admin_dashboard/config/plugins/logger_pluggin.dart';
import 'package:fl_admin_dashboard/features/auth/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_service_provider.dart';

part 'auth_state_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  AuthState() {
    _checkLogin();
  }

  final _logger = const Logger('AuthStateProvider');

  @override
  AuthValues build() {
    return AuthValues(
      usuario: null,
      status: AuthStatus.checking,
    );
  }

  void _checkLogin() async {
    _logger.log('Verificando login');
    final service = ref.read(authServiceProvider);
    final result = await service.checkLogin();
    if (result == null) {
      state = state.copyWith(status: AuthStatus.notauthenticated);
    } else {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        usuario: result.$1,
      );
    }
  }

  void login() async {
    final service = ref.read(authServiceProvider);
    final result = await service.login();
    if (result == null) return;
    state = state.copyWith(
      status: AuthStatus.authenticated,
      usuario: result.$1,
    );
  }

  void register() async {
    final service = ref.read(authServiceProvider);
    final result = await service.register();
    if (result == null) return;
    state = state.copyWith(
      status: AuthStatus.authenticated,
      usuario: result.$1,
    );
  }

  void logout() async {
    state = state.copyWith(status: AuthStatus.notauthenticated, usuario: null);
  }
}

class AuthValues {
  AuthValues({
    required this.usuario,
    required this.status,
  });

  final Usuario? usuario;
  final AuthStatus status;

  AuthValues copyWith({
    Usuario? usuario,
    AuthStatus? status,
  }) {
    return AuthValues(
      usuario: usuario,
      status: status ?? this.status,
    );
  }
}
