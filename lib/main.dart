import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dashboard",
      // routes: AppRouter.rutasApp,
      // initialRoute: AppRouter.root,
      home: Scaffold(),
    );
  }
}
