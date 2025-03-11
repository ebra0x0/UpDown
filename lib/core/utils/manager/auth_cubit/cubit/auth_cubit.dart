import 'dart:async';

import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStateInitial());

  late StreamSubscription<Session?>? _authSubscription;

  void authMonitor() {
    gitIt.get<ApiService>().sessionMonitor();
    _authSubscription =
        gitIt.get<ApiService>().onAuthStateChange.listen((session) async {
      if (session != null && !session.isExpired) {
        emit(AuthStateAuthenticated(user: session.user));
      } else if (session != null && session.isExpired) {
        final String? refreshToken =
            await gitIt.get<SecureStorage>().get("refresh_token");
        if (refreshToken == null) {
          emit(AuthStateUnAuthenticated());
          return;
        }
        final session =
            await gitIt.get<ApiService>().refreshToken(refreshToken);
        session.fold((failure) => emit(AuthStateUnAuthenticated()), (session) {
          gitIt
              .get<SecureStorage>()
              .add("refresh_token", session!.refreshToken!);
          emit(AuthStateAuthenticated(user: session.user));
        });
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
