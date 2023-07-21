import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/helpers/cafe_api.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';

void main() async {
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoute();
  CafeApi.setupDio();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (_) => AuthProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => SideMenuProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => CategoriasProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Dashboard',
      initialRoute: Flurorouter.rootRoute,
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navKey,
      scaffoldMessengerKey: NotificationService.messengerKey,
      builder: (_, child) {
        final auth = Provider.of<AuthProvider>(context);

        if (auth.authStatus == AuthStatus.checking) {
          return const SplashLayout();
        }

        if (auth.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(
            child: child ?? const CircularProgressIndicator(),
          );
        }

        return AuthLayout(
          child: child ?? const CircularProgressIndicator(),
        );
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
        thumbColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.5)),
      )),
    );
  }
}
