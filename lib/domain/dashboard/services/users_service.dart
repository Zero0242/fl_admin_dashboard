import 'package:file_picker/file_picker.dart';

import '../../auth/auth.dart';

abstract class UsersService {
  Future<List<Usuario>> getUsuarios();
  Future<Usuario> getUsuarioById(String id);
  Future<Usuario?> createUsuario(Map<String, dynamic> form);
  Future<Usuario?> updateUsuario(String id, Map<String, dynamic> form);
  Future<Usuario?> deleteUsuario(String id);
  Future<Usuario?> addAvatar(String id, PlatformFile file);
}
