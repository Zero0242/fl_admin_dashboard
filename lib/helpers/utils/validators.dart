import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

typedef LengthValidation = ({int minLength, int? maxLength, String? message});

/// Utilidades de validaciones de textos y restricciones a inputs
class Validators {
  /// Valida si la longitud del texto cumple con el limite
  static String? Function(String?) _validateLength(LengthValidation options) {
    final (:maxLength, :minLength, :message) = options;
    return (value) {
      final current = value ?? '';
      if (current.length < minLength) {
        return message ?? 'Requiere tener como minimo $minLength caracteres';
      }
      if (maxLength == null) return null;
      if (current.length > maxLength) {
        return message ?? 'Máximo $maxLength caracteres permitidos';
      }

      return null;
    };
  }

  /// Valida si no viene vacío el texto
  /// * `message` mensaje de cuando viene vacio
  /// * `options` para crear la validacion de longitud
  static String? Function(String?) createValidation({
    String message = 'Debe ingresar un valor',
    LengthValidation? options,
    bool isEmail = false,
  }) {
    return (value) {
      final current = value ?? '';
      if (current.isEmpty) return message;
      if (options != null) return _validateLength(options)(value);
      if (isEmail) {
        if (!EmailValidator.validate(current)) {
          return 'Debe ingresar un email válido';
        }
      }

      return null;
    };
  }

  /// Valida los numeros de un input, solo los double
  /// * `min` minimo del numero
  /// * `max` maximo del numero
  /// * `message` mensaje de validacion
  /// * `emptyMessage` mensaje de vacio
  static String? Function(String?) validateDouble({
    required double min,
    required double max,
    String message = 'El valor debe estar dentro del rango especificado',
    String emptyMessage = 'El valor no puede quedar vacio',
  }) {
    return (value) {
      if (value == null || value.isEmpty) return emptyMessage;
      final double count = double.tryParse(value) ?? 0.0;
      if (count < min || count > max) return message;
      return null;
    };
  }

  /// Valida los numeros de un input, solo los int
  /// * `min` minimo del numero
  /// * `max` maximo del numero
  /// * `message` mensaje de validacion
  /// * `emptyMessage` mensaje de vacio
  static String? Function(String?) validateNumber({
    required int min,
    required int max,
    String message = 'El valor debe estar dentro del rango especificado',
    String emptyMessage = 'El valor no puede quedar vacio',
  }) {
    return (value) {
      if (value == null || value.isEmpty) return emptyMessage;
      final int count = int.tryParse(value) ?? 0;
      if (count < min || count > max) return message;
      return null;
    };
  }

  /// Valida que el valor sea un número, filtra los intentos de input
  /// * `validatePhoneNumber` que el numero pueda ser telefonico
  /// * `maxLength` cantidad maxima de caracteres
  static List<TextInputFormatter> createNumberValidation({
    bool validatePhoneNumber = false,
    int? maxLength,
  }) {
    return [
      validatePhoneNumber
          ? FilteringTextInputFormatter.deny(RegExp(r'[^0-9+]'))
          : FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
    ];
  }

  /// Valida que un valor sea decimal
  /// * `maxLength` cantidad maxima de caracteres
  static List<TextInputFormatter> createDecimalValidation({int? maxLength}) {
    return [
      FilteringTextInputFormatter.deny(RegExp(r'[^0-9.]')),
      if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
    ];
  }

  /// Valida que el valor solo sea texto, filtra los intentos de input
  static List<TextInputFormatter> createTextValidation({int? maxLength}) {
    return [
      FilteringTextInputFormatter.deny(
        RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'),
      ),
      if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
    ];
  }
}
