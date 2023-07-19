import 'package:flutter/material.dart';

class SideMenuProvider {
  static late AnimationController menuController;
  static bool isMenuOpen = false;

  static Animation<double> movement =
      Tween<double>(begin: -200, end: 0).animate(
    CurvedAnimation(parent: menuController, curve: Curves.easeInOut),
  );
  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(parent: menuController, curve: Curves.easeInOut),
  );

  static void openMenu() {
    isMenuOpen = true;
    menuController.forward();
  }

  static void closeMenu() {
    isMenuOpen = false;
    menuController.reverse();
  }

  static void toggleMenu() {
    (isMenuOpen) ? menuController.reverse() : menuController.forward();
    isMenuOpen = !isMenuOpen;
  }
}
