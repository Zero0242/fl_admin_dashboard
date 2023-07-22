import 'package:admin_dashboard/helpers/cafe_api.dart';
import 'package:admin_dashboard/models/usuario_auth.dart';
import 'package:flutter/material.dart';

class UserFormProvider extends ChangeNotifier {
  Usuario? user;

  late GlobalKey<FormState> formKey;

  // Todo: actualizar el usuario

  bool _validForm() => formKey.currentState!.validate();

  copyUserWith({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
  }) {
    user = Usuario(
      rol: rol ?? user!.rol,
      estado: estado ?? user!.estado,
      google: google ?? user!.google,
      nombre: nombre ?? user!.nombre,
      correo: correo ?? user!.correo,
      uid: uid ?? user!.uid,
    );
    notifyListeners();
  }

  Future updateUser() async {
    if (!_validForm()) return;
    final data = {
      "nombre": user!.nombre,
      "correo": user!.correo,
    };

    try {
      final resp = await CafeApi.httpPut(endpoint: '/usuarios/${user!.uid}', data: data);

      return true;
    } catch (e) {
      return false;
    }
  }
}
