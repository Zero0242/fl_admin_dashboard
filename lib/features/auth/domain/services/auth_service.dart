import '../models/usuario.dart';

abstract class AuthService {
  Future<(Usuario, String)?> login();
  Future<(Usuario, String)?> register();
  Future<(Usuario, String)?> checkLogin();
}
