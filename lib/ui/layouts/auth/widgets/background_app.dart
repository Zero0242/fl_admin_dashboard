import 'package:flutter/material.dart';

class BackgroundApp extends StatelessWidget {
  const BackgroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildDecorationImage(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset(
              'assets/twitter-white-logo.png',
              width: 400,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildDecorationImage() {
    return const BoxDecoration(
      color: Colors.black,
      image: DecorationImage(
          image: AssetImage('assets/twitter-bg.png'), fit: BoxFit.cover),
    );
  }
}
