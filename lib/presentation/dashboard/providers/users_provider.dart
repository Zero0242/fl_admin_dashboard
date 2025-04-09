import 'package:file_picker/file_picker.dart';
import 'package:fl_admin_dashboard/domain/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/dashboard/dashboard.dart';
import '../../../domain/dashboard/dashboard.dart';

part 'users_provider.g.dart';

@riverpod
UsersService usersService(Ref ref) {
  return UsersServiceApi();
}

@riverpod
class UserProviderById extends _$UserProviderById {
  @override
  FutureOr<Usuario> build(String id) {
    final service = ref.read(usersServiceProvider);
    return service.getUsuarioById(id);
  }

  Future<void> updateUser({
    required String name,
    required String correo,
  }) async {
    final service = ref.read(usersServiceProvider);
    final result =
        await service.updateUsuario(id, {'nombre': name, 'correo': correo});
    if (result == null) return;
    ref.invalidateSelf();
    ref.invalidate(usersNotifierProvider);
  }

  void deleteUser() async {
    final service = ref.read(usersServiceProvider);
    final result = await service.deleteUsuario(id);
    if (result == null) return;
    ref.invalidateSelf();
    ref.invalidate(usersNotifierProvider);
  }

  Future<void> updateUserAvatar(PlatformFile file) async {
    final service = ref.read(usersServiceProvider);
    final result = await service.addAvatar(id, file);
    if (result == null) return;
    ref.invalidateSelf();
    ref.invalidate(usersNotifierProvider);
  }
}

@riverpod
class UsersNotifier extends _$UsersNotifier {
  @override
  FutureOr<List<Usuario>> build() {
    final service = ref.read(usersServiceProvider);
    return service.getUsuarios();
  }

  void addUser({
    required String email,
    required String password,
    required String fullname,
  }) async {
    final service = ref.read(usersServiceProvider);
    final result = await service.createUsuario(
      {"correo": email, "password": password, "nombre": fullname},
    );
    if (result == null) {
      state = AsyncData(state.requireValue);
    } else {
      state = AsyncData([result, ...state.requireValue]);
    }
  }
}
