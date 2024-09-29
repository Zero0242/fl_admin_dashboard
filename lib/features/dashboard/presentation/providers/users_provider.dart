import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/features/auth/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/domain.dart';
import '../../infraestructure/infraestructure.dart';

part 'users_provider.g.dart';

@riverpod
UsersService usersService(UsersServiceRef ref) {
  return UsersServiceApi();
}

@riverpod
FutureOr<Usuario> userProviderById(UserProviderByIdRef ref, String id) {
  final service = ref.read(usersServiceProvider);
  return service.getUsuarioById(id);
}

@riverpod
class UsersNotifier extends _$UsersNotifier {
  UsersNotifier() {
    Future.microtask(_initialLoad);
  }
  @override
  List<Usuario> build() {
    return [];
  }

  Logger get _logger => const Logger('CategoriesNotifier');

  void _initialLoad() async {
    _logger.log('Loading...');
    final service = ref.read(usersServiceProvider);
    state = await service.getUsuarios();
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
    if (result == null) return;
    state = [result, ...state];
  }

  void updateUser(String id, String name) async {
    final service = ref.read(usersServiceProvider);
    // final result = await service.updateCategoria(id, {'nombre': name});
    // if (result == null) return;
    // state = state.map((e) {
    //   if (e.id == id) return e.copyWith(nombre: name);
    //   return e;
    // }).toList();
  }

  void deleteUser(String id) async {
    final service = ref.read(usersServiceProvider);
    final result = await service.deleteUsuario(id);
    if (result == null) return;
    state = state.where((e) => e.id != id).toList();
  }
}
