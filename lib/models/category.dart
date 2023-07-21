class Categoria {
  String id;
  String nombre;
  _Usuario usuario;

  Categoria({
    required this.id,
    required this.nombre,
    required this.usuario,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["_id"],
        nombre: json["nombre"],
        usuario: _Usuario.fromJson(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "usuario": usuario.toJson(),
      };

  @override
  String toString() => 'Categoria: ${nombre} ';
}

class _Usuario {
  String id;
  String nombre;

  _Usuario({
    required this.id,
    required this.nombre,
  });

  factory _Usuario.fromJson(Map<String, dynamic> json) => _Usuario(
        id: json["_id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
      };
}
