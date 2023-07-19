import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration authInputDecoration({
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

  static InputDecoration searchInputDecoration({
    required String hint,
    required IconData icon,
  }) =>
      InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey),
          labelStyle: const TextStyle(color: Colors.grey),
          hintStyle: const TextStyle(color: Colors.grey));
}
