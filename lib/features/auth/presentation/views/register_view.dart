import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout/auth_layout.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static const String route = 'register';
  static const String fullRoute = '${AuthLayout.path}/$route';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formulario = GlobalKey<FormState>();
  final fullname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  void onSubmit() {
    // final res = formulario.currentState?.validate()??false;
    // if (!res) return;
    // final auth = of<AuthProvider>(context, listen: false);
    // auth.register(
    //   email: email.text,
    //   password: password.text,
    //   name: fullname.text,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formulario,
            child: Column(
              children: [
                TextFormField(
                  controller: fullname,
                  style: const TextStyle(color: Colors.white),
                  decoration: CustomInputs.authInputDecoration(
                    hint: 'Ingrese su nombre',
                    label: 'Nombre',
                    iconData: Icons.supervised_user_circle_outlined,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: email,
                  style: const TextStyle(color: Colors.white),
                  validator: Validators.createValidation(isEmail: true),
                  decoration: CustomInputs.authInputDecoration(
                    hint: 'Ingrese su correo',
                    label: 'Correo',
                    iconData: Icons.email_outlined,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: password,
                  style: const TextStyle(color: Colors.white),
                  validator: Validators.createValidation(
                    options: (minLength: 6, maxLength: null, message: null),
                  ),
                  decoration: CustomInputs.authInputDecoration(
                    hint: '*******',
                    label: 'Contraseña',
                    iconData: Icons.lock_outline,
                  ),
                ),
                const SizedBox(height: 20),
                CustomOutlinedButton(
                  onPressed: onSubmit,
                  text: 'Crear Cuenta',
                ),
                const SizedBox(height: 20),
                LinkText(
                  text: 'Ir al login',
                  onTap: () => (context).go(LoginView.fullRoute),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
