// ignore_for_file: public_member_api_docs, sort_constructors_first
class Categoria {
  Categoria({
    required this.id,
    required this.nombre,
    required this.usuario,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    String usuario = '';
    if (json['usuario'] is String) {
      usuario = json['usuario'];
    } else {
      usuario = json["usuario"]?['nombre'] ?? '';
    }
    return Categoria(
      id: json["_id"],
      nombre: json["nombre"],
      usuario: usuario,
    );
  }
  final String id;
  final String nombre;
  final String usuario;

  Categoria copyWith({
    String? id,
    String? nombre,
    String? usuario,
  }) {
    return Categoria(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      usuario: usuario ?? this.usuario,
    );
  }
}
