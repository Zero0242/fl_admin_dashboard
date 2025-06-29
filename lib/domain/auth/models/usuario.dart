// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fl_admin_dashboard/config/config.dart';

class Usuario {
  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rol,
    this.avatar,
  });

  final String id;
  final String nombre;
  final String correo;
  final String rol;
  final String? avatar;

  factory Usuario.fromMap(Map<String, dynamic> map) {
    final url = [
      Envs.getApiUrl(),
      'api/uploads/usuarios',
      map['uid'],
    ].join('/');
    return Usuario(
      id: map['uid'] as String,
      nombre: map['nombre'] as String,
      correo: map['correo'] as String,
      rol: map['rol'] as String,
      // avatar: map['img'] ?? map['avatar'],
      avatar: url,
    );
  }
}
