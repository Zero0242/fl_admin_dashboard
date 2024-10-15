// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_admin_dashboard/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_form_provider.g.dart';

@riverpod
class LoginForm extends _$LoginForm {
  @override
  LoginFormState build() {
    return LoginFormState();
  }

  void onEmailChange(String value) {
    state = state.copyWith(email: value);
  }

  void onPasswordChange(String value) {
    state = state.copyWith(password: value);
  }

  void onSubmit() {
    final validate =
        ref.read(loginFormKeyProvider).currentState?.validate() ?? false;

    if (!validate) return;
    ref.read(authProvider.notifier).login(state.email, state.password);
  }
}

@riverpod
GlobalKey<FormState> loginFormKey(LoginFormKeyRef ref) {
  return GlobalKey<FormState>();
}

class LoginFormState {
  LoginFormState({
    this.email = '',
    this.password = '',
  });

  final String email;
  final String password;

  LoginFormState copyWith({
    String? email,
    String? password,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
