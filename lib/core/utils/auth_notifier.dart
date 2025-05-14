import 'dart:async';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:flutter/widgets.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthCubit authCubit;
  late final StreamSubscription<AuthState> _subscription;

  AuthNotifier(this.authCubit) {
    _subscription = authCubit.stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
