import '../usuario_auth.dart';

class UsersResponse {
  int total;
  List<Usuario> usuarios;

  UsersResponse({
    required this.total,
    required this.usuarios,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        total: json["total"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
      };
}
