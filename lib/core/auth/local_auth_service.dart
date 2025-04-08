import '../../domain/auth/auth.dart';

class LocalAuthService extends AuthService {
  Usuario get _defaultUser {
    return Usuario(
      id: '1',
      nombre: 'John Doe',
      correo: 'johndoe@email.com',
      rol: '',
    );
  }

  @override
  Future<(Usuario, String)?> login(Map<String, dynamic> form) async {
    await Future.delayed(const Duration(seconds: 1));

    return (_defaultUser, 'token-de-autenticacion');
  }

  @override
  Future<(Usuario, String)?> register(Map<String, dynamic> form) async {
    await Future.delayed(const Duration(seconds: 1));

    return (_defaultUser, 'token-de-autenticacion');
  }

  @override
  Future<(Usuario, String)?> checkLogin() async {
    await Future.delayed(const Duration(seconds: 1));

    return (_defaultUser, 'token-de-autenticacion');
  }
}
