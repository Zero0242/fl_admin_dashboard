import '../models/usuario.dart';

abstract class AuthService {
  Future<(Usuario, String)?> login(Map<String, String> form);
  Future<(Usuario, String)?> register(Map<String, String> form);
  Future<(Usuario, String)?> checkLogin();
}
