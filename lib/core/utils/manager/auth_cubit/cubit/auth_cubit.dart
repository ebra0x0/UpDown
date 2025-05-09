import 'package:UpDown/features/auth/data/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthStateInitial());
  final AuthRepo authRepo;

  void sessionMonitor() {
    authRepo.sessionMonitor.listen((session) async {
      if (session == null) {
        emit(AuthStateUnAuthenticated());
        return;
      } else if (session.user.email != null &&
          session.user.emailConfirmedAt == null) {
        emit(AuthStateUnconfirmed(email: session.user.email!));
        return;
      }
      checkAccountStatus(session: session);
    });
  }

  Future<void> signOut() async {
    emit(AuthStateLoading());
    final res = await authRepo.signOut();
    res.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (success) => emit(AuthStateUnAuthenticated()));
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthStateLoading());
    final res =
        await authRepo.signInWithPassword(email: email, password: password);
    res.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (session) => null);
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthStateLoading());
    final res = await authRepo.signUp(email: email, password: password);
    res.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (session) {
      if (session == null) {
        emit(AuthStateUnconfirmed(email: email));
        return;
      }
    });
  }

  Future<void> sendConfirmationEmail({required String email}) async {
    emit(AuthStateLoading());
    final res = await authRepo.sendConfirmationEmail(email);
    res.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (success) {
      emit(AuthStateUnconfirmed(email: email));
    });
  }

  Future<void> checkAccountStatus({required Session session}) async {
    final res = await authRepo.isNewAccount();
    return res
        .fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
            (isNew) {
      if (isNew) {
        emit(AuthStateNewUser(session: session));
        return;
      }
      emit(AuthStateAuthenticated(session: session));
    });
  }

  void resetState() => emit(AuthStateInitial());
}
