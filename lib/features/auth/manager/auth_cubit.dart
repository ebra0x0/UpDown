import 'package:UpDown/core/utils/model/user_credentials_model.dart';
import 'package:UpDown/features/auth/repos/auth_repo.dart';
import 'package:UpDown/features/auth/repos/token_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepo authRepo, required TokenRepository tokenRepo})
      : _authRepo = authRepo,
        _tokenRepo = tokenRepo,
        super(AuthState()) {
    sessionMonitor();
  }

  final AuthRepo _authRepo;
  final TokenRepository _tokenRepo;

  void sessionMonitor() {
    _authRepo.sessionMonitor.listen((session) async {
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
    }, onError: (error) {
      emit(
          state.copyWith(status: AuthStatus.error, errorMsg: error.toString()));
    });
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final res = await _authRepo.signOut();
    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error,
            errorMsg: failure.errMessage)), (success) async {
      await _tokenRepo.clearTokens();
      resetState();
      emit(state.copyWith(status: AuthStatus.unAuthenticated));
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final UserCredentialsModel credentials =
        UserCredentialsModel(email: email, password: password);

    final res = await _authRepo.signInWithPassword(credentials: credentials);

    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error, errorMsg: failure.errMessage)),
        (session) async => await _tokenRepo.setTokens(
            accessToken: session.accessToken,
            refreshToken: session.refreshToken));
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final UserCredentialsModel credentials =
        UserCredentialsModel(email: email, password: password);

    final res = await _authRepo.signUp(credentials: credentials);

    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error,
            errorMsg: failure.errMessage)), (session) async {
      if (session == null) {
        emit(state.copyWith(status: AuthStatus.unconfirmed, email: email));
        return;
      }
      await _tokenRepo.setTokens(
          accessToken: session.accessToken, refreshToken: session.refreshToken);
    });
  }

  Future<void> sendConfirmationEmail({required String email}) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final res = await _authRepo.sendConfirmationEmail(email);
    res.fold(
        (failure) => emit(state.copyWith(
            status: AuthStatus.error,
            errorMsg: failure.errMessage)), (success) {
      emit(state.copyWith(status: AuthStatus.unconfirmed, email: email));
    });
  }

  Future<void> checkAccountStatus({required Session session}) async {
    final res = await _authRepo.isNewAccount();
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
