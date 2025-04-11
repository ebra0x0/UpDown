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
      if (session != null && !session.isExpired) {
        emit(AuthStateAuthenticated(user: session.user));
      } else if (session != null && session.isExpired) {
        final String? refreshToken = await authRepo.getRefreshToken();

        if (refreshToken == null) {
          emit(AuthStateUnAuthenticated());
          return;
        }

        final session = await authRepo.refreshToken(refreshToken);

        session.fold((failure) => emit(AuthStateUnAuthenticated()), (session) {
          authRepo.setRefreshToken(refreshToken);
          emit(AuthStateAuthenticated(user: session!.user));
        });
      } else {
        emit(AuthStateUnAuthenticated());
      }
    });
  }

  void signOut() async {
    emit(AuthStateLoading());
    final signOut = await authRepo.signOut();
    signOut.fold(
        (failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (success) => emit(AuthStateUnAuthenticated()));
  }

  void signIn({required String email, required String password}) async {
    emit(AuthStateLoading());
    final signIn =
        await authRepo.signInWithPassword(email: email, password: password);
    signIn.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (session) => emit(AuthStateAuthenticated(user: session.user)));
  }

  void signUp({required String email, required String password}) async {
    emit(AuthStateLoading());
    final signUp = await authRepo.signUp(email: email, password: password);
    signUp.fold((failure) => emit(AuthStateError(errorMsg: failure.errMessage)),
        (session) => emit(AuthStateAuthenticated(user: session.user)));
  }
}
