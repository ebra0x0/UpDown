import 'dart:async';

import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/auth/data/model/auth_request_model.dart';
import 'package:UpDown/features/auth/data/model/auth_response_model.dart';
import 'package:UpDown/features/auth/data/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AuthState()) {
    authStateMonitor();
  }

  final AuthRepo _authRepo;
  StreamSubscription<AuthResponseModel>? _authSub;

  void authStateMonitor() {
    _authSub = _authRepo.getAuthState().listen((authRes) {
      emit(state.copyWith(
          status: authRes.status,
          session: authRes.session,
          user: authRes.user));
    }, onError: (e) {
      emit(state.copyWith(status: AuthStatus.error));
    });
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));

    final res = await _authRepo.signOut();

    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error, errorMsg: failure.errMessage)),
        (_) => resetState());
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final AuthRequestModel credentials =
        AuthRequestModel(email: email, password: password);

    final res = await _authRepo.signInWithPassword(credentials: credentials);

    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error, errorMsg: failure.errMessage)),
        (_) {});
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final AuthRequestModel credentials =
        AuthRequestModel(email: email, password: password);

    final res = await _authRepo.signUp(credentials: credentials);

    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error, errorMsg: failure.errMessage)),
        (_) {});
  }

  Future<void> sendConfirmationEmail(String email) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final res = await _authRepo.sendConfirmationEmail(email);

    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error, errorMsg: failure.errMessage)),
        (_) {});
  }

  void updateStatus(AuthStatus status) {
    emit(state.copyWith(status: status));
  }

  void resetState() => emit(state.reset());

  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}
