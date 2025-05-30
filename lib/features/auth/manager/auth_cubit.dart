import 'package:UpDown/features/auth/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthState());
  final AuthRepo authRepo;

  void sessionMonitor() {
    authRepo.sessionMonitor.listen((session) async {
      if (session == null) {
        emit(state.copyWith(status: AuthStatus.unAuthenticated));
        return;
      } else if (session.user.email != null &&
          session.user.emailConfirmedAt == null) {
        emit(state.copyWith(
            status: AuthStatus.unconfirmed, email: session.user.email));
        return;
      }
      await checkAccountStatus(session: session);
    });
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final res = await authRepo.signOut();
    resetState();
    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error, errorMsg: failure.errMessage)),
        (success) => emit(state.copyWith(status: AuthStatus.unAuthenticated)));
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final res =
        await authRepo.signInWithPassword(email: email, password: password);
    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error, errorMsg: failure.errMessage)),
        (session) => null);
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final res = await authRepo.signUp(email: email, password: password);
    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error,
            errorMsg: failure.errMessage)), (session) {
      if (session == null) {
        emit(state.copyWith(status: AuthStatus.unconfirmed, email: email));
        return;
      }
    });
  }

  Future<void> sendConfirmationEmail({required String email}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final res = await authRepo.sendConfirmationEmail(email);
    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error,
            errorMsg: failure.errMessage)), (success) {
      emit(state.copyWith(status: AuthStatus.unconfirmed, email: email));
    });
  }

  Future<void> checkAccountStatus({required Session session}) async {
    final res = await authRepo.isNewAccount();
    return res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error, errorMsg: failure.errMessage)), (isNew) {
      if (isNew) {
        emit(state.copyWith(status: AuthStatus.newAccount, session: session));
        return;
      }
      emit(state.copyWith(status: AuthStatus.authenticated, session: session));
    });
  }

  void resetState() => emit(state.reset());
}
