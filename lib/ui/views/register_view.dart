import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:email_validator/email_validator.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/signin_form_provider.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';

import '../inputs/custom_inputs.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const String route = '/Login';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInProvider(),
      child: Container(
        margin: const EdgeInsets.only(top: 80),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 370),
            child: Builder(builder: (context) {
              final provider = Provider.of<SignInProvider>(context, listen: false);
              return Form(
                autovalidateMode: AutovalidateMode.always,
                key: provider.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) => provider.nombre,
                      decoration: CustomInputs.authInputDecoration(
                        hint: 'Ingrese su nombre',
                        label: 'Nombre',
                        iconData: Icons.supervised_user_circle_outlined,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) => provider.email,
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? '')) {
                          return 'Email no valido';
                        }
                        return null;
                      },
                      decoration: CustomInputs.authInputDecoration(
                        hint: 'Ingrese su correo',
                        label: 'Correo',
                        iconData: Icons.email_outlined,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) => provider.password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese su contraseña';
                        }
                        if (value.length < 6) {
                          return 'La contraseña debe tener más de 6 caracteres';
                        }
                        return null;
                      },
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
                        if (!res) return;

                        final auth = Provider.of<AuthProvider>(context);

                        auth.register(
                          email: provider.email,
                          password: provider.password,
                          name: provider.nombre,
                        );
                      },
                      text: 'Crear Cuenta',
                    ),
                    const SizedBox(height: 20),
                    LinkText(
                      text: 'Ir al login',
                      onTap: () => Navigator.of(context).pushReplacementNamed(Flurorouter.loginRoute),
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
