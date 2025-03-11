import 'dart:async';

import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/secure_storage.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/auth/data/model/auth_user_model.dart';
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

  void signOut() async {
    final signOut = await gitIt.get<ApiService>().signOut();
    signOut.fold(
        (failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (success) => emit(AuthStateUnAuthenticated()));
  }

  void signIn(AuthUserModel user) async {
    emit(AuthStateLoading());
    final signIn = await gitIt.get<ApiService>().signInWithPassword(user);
    signIn.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (session) => emit(AuthStateAuthenticated(user: session.user)));
  }

  void signUp(AuthUserModel user) async {
    emit(AuthStateLoading());
    final signUp = await gitIt.get<ApiService>().signUp(user);
    signUp.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (session) => emit(AuthStateAuthenticated(user: session.user)));
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}
