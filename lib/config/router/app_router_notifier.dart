import 'package:fl_admin_dashboard/features/auth/auth.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final appRouterNotifier = Provider((ref) {
  final authNotifier = ref.read(authStateProvider.notifier);
  return AppRouterNotifier(authNotifier);
});

class AppRouterNotifier extends ChangeNotifier {
  AppRouterNotifier(this._notifier) {
    _notifier.addListener((state) {
      authStatus = state.status;
    });
  }
  final AuthStateNotifier _notifier;

  AuthStatus _authStatus = AuthStatus.checking;
  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
