import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      print('Form Valid ... login');
    } else {
      print('formulario invalido');
    }

    return formKey.currentState!.validate();
  }
}
