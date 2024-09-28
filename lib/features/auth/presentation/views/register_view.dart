import 'package:flutter/material.dart';

import '../layout/auth_layout.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const String route = 'register';
  static const String fullRoute = '${AuthLayout.path}/$route';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text('Register Screen body'),
    );
  }
}
