import 'dart:async';

import 'package:UpDown/core/utils/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStateInitial());

  StreamSubscription? _authSubscription;

  void authMonitor() {
    _authSubscription =
        ApiService.supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;

      if (session != null) {
        emit(AuthStateAuthenticated(user: session.user));
      } else {
        emit(AuthStateUnAuthenticated());
      }
    });
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}
