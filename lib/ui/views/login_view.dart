import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String route = '/Login';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: buildInputDecoration(
                    hint: 'Ingrese su correo',
                    label: 'Email',
                    iconData: Icons.email_outlined,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: buildInputDecoration(
                    hint: '*******',
                    label: 'Contraseña',
                    iconData: Icons.lock_outline,
                  ),
                ),
                const SizedBox(height: 20),
                CustomOutlinedButton(
                  onPressed: () {},
                  text: 'Ingresar',
                  filled: true,
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
                const LinkText(text: 'Nueva Cuenta')
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration({
    required String hint,
    required String label,
    required IconData iconData,
  }) =>
      InputDecoration(
        hintText: hint,
        labelText: label,
        prefix: Icon(iconData, color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      );
}
