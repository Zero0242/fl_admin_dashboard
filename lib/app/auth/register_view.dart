import 'package:fl_admin_dashboard/helpers/utils/utils.dart';
import 'package:fl_admin_dashboard/presentation/auth/auth.dart';
import 'package:fl_admin_dashboard/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_layout.dart';
import 'login_view.dart';

class RegisterView extends HookConsumerWidget {
  const RegisterView({super.key});
  static const String route = 'register';
  static const String fullRoute = '${AuthLayout.path}/$route';

  @override
  Widget build(BuildContext context, ref) {
    final formulario = useMemoized(() => GlobalKey<FormState>());
    final fullname = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();
    return Container(
      margin: const EdgeInsets.only(top: 50),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formulario,
            child: Column(
              spacing: 20,
              children: <Widget>[
                TextFormField(
                  controller: fullname,
                  style: const TextStyle(color: Colors.white),
                  decoration: CustomInputs.authInputDecoration(
                    hint: 'Ingrese su nombre',
                    label: 'Nombre',
                    iconData: Icons.supervised_user_circle_outlined,
                  ),
                ),

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

                CustomOutlinedButton(
                  onPressed: () {
                    final res = formulario.currentState?.validate() ?? false;
                    if (!res) return;
                    ref
                        .read(authProvider.notifier)
                        .register(
                          email: email.text,
                          password: password.text,
                          fullname: fullname.text,
                        );
                  },
                  text: 'Crear Cuenta',
                ),

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
