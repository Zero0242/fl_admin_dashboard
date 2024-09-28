import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/twitter-bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset(
              'assets/images/twitter-white-logo.png',
              width: 400,
            ),
          ),
        ),
      ),
    );
  }
}
