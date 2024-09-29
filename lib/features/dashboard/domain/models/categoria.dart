import 'categoria_user.dart';

class Categoria {
  Categoria({
    required this.id,
    required this.nombre,
    required this.usuario,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json["_id"],
      nombre: json["nombre"],
      usuario: CategoriaUser.fromJson(json["usuario"]),
    );
  }
  String id;
  String nombre;
  CategoriaUser usuario;
}
