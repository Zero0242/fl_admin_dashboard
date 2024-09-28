import 'package:fl_admin_dashboard/config/config.dart';
import 'package:fl_admin_dashboard/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../layout/auth_layout.dart';
import '../providers/providers.dart';
import 'register_view.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});
  static const String route = 'login';
  static const String fullRoute = '${AuthLayout.path}/$route';

  @override
  Widget build(BuildContext context, ref) {
    final formNotifier = ref.read(loginFormProvider.notifier);
    final formKey = ref.watch(loginFormKeyProvider);
    return Container(
      margin: const EdgeInsets.only(top: 80),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: formNotifier.onEmailChange,
                  validator: Validators.createValidation(isEmail: true),
                  decoration: CustomInputs.authInputDecoration(
                    hint: 'Ingrese su correo',
                    label: 'Email',
                    iconData: Icons.email_outlined,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: formNotifier.onPasswordChange,
                  validator: Validators.createValidation(
                    options: (minLength: 6, maxLength: null, message: null),
                  ),
                  style: const TextStyle(color: Colors.white),
                  decoration: CustomInputs.authInputDecoration(
                    hint: '*******',
                    label: 'Contraseña',
                    iconData: Icons.lock_outline,
                  ),
                ),
                const SizedBox(height: 20),
                CustomOutlinedButton(
                  onPressed: formNotifier.onSubmit,
                  text: 'Ingresar',
                  filled: true,
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
                LinkText(
                  text: 'Nueva Cuenta',
                  onTap: () {
                    context.pushReplacementNamed(RegisterView.fullRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
