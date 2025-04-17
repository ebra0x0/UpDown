import 'package:UpDown/features/auth/data/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthStateInitial()) {
    authMonitor();
  }

  final AuthRepo authRepo;

  void authMonitor() {
    authRepo.sessionMonitor.listen((session) async {
      if (session == null) {
        emit(AuthStateUnAuthenticated());
      }

      emit(AuthStateAuthenticated(session: session!));
    });
  }

  void signOut() async {
    emit(AuthStateLoading());
    final res = await authRepo.signOut();
    res.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (success) => emit(AuthStateUnAuthenticated()));
  }

  void signIn({required String email, required String password}) async {
    emit(AuthStateLoading());
    final res =
        await authRepo.signInWithPassword(email: email, password: password);
    res.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (session) => emit(AuthStateAuthenticated(session: session)));
  }

  void signUp({required String email, required String password}) async {
    emit(AuthStateLoading());
    final res = await authRepo.signUp(email: email, password: password);
    res.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (session) {
      if (session == null) {
        emit(AuthStateUnconfirmed());
      }
      emit(AuthStateAuthenticated(session: session!));
    });
  }
}
