import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/domain.dart';
import '../../infraestructure/infraestructure.dart';

part 'auth_service_provider.g.dart';

@riverpod
AuthService authService(AuthServiceRef ref) {
  return AuthServiceApi();
}
