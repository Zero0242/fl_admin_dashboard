import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/login_form_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../inputs/custom_inputs.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String route = '/Login';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Container(
        margin: const EdgeInsets.only(top: 80),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 370),
            child: Builder(builder: (context) {
              final provider = Provider.of<LoginFormProvider>(context, listen: false);
              return Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: provider.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) => provider.email = value,
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? '')) {
                          return 'Email no válido';
                        }
                        return null;
                      },
                      decoration: CustomInputs.authInputDecoration(
                        hint: 'Ingrese su correo',
                        label: 'Email',
                        iconData: Icons.email_outlined,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) => provider.password = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese su contraseña';
                        }
                        if (value.length < 6) {
                          return 'La contraseña debe tener más de 6 caracteres';
                        }

                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.authInputDecoration(
                        hint: '*******',
                        label: 'Contraseña',
                        iconData: Icons.lock_outline,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomOutlinedButton(
                      onPressed: () {
                        final res = provider.validateForm();

                        if (res) {
                          auth.login(provider.email, provider.password);
                        }
                      },
                      text: 'Ingresar',
                      filled: true,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 20),
                    LinkText(
                      text: 'Nueva Cuenta',
                      onTap: () => Navigator.of(context).pushReplacementNamed(Flurorouter.registerRoute),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
