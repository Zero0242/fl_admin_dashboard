import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String nombre = '';
  String email = '';
  String password = '';

  bool validateForm() => formKey.currentState!.validate();
}
