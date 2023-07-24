import 'services/services.dart';
import 'providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/helpers/cafe_api.dart';
import 'package:admin_dashboard/ui/layouts/layouts.dart';

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
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => SideMenuProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => CategoriasProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => UserFormProvider()),
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
