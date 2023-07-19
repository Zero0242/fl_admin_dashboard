import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static navigateTo(String routeName) =>
      navKey.currentState!.pushNamed(routeName);

  static replaceTo(String routeName) =>
      navKey.currentState!.pushReplacementNamed(routeName);
}
