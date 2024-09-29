class CategoriaUser {
  CategoriaUser({
    required this.id,
    required this.nombre,
  });

  factory CategoriaUser.fromJson(Map<String, dynamic> json) {
    return CategoriaUser(
      id: json["_id"],
      nombre: json["nombre"],
    );
  }
  String id;
  String nombre;
}
