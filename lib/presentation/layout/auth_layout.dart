import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.child});
  static const String path = '/auth';
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height - kBottomNavigationBarHeight,
        width: size.width,
        color: Colors.red,
        child: Row(
          children: <Widget>[
            Container(
              width: 600,
              height: double.infinity,
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const SizedBox(height: 50),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
