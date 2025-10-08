part of 'auth_cubit.dart';

class AuthState {
  final AuthStatus status;
  final String? errorMsg;
  final Session? session;
  final User? user;

  const AuthState(
      {this.status = AuthStatus.initial,
      this.errorMsg,
      this.session,
      this.user});

  AuthState copyWith(
      {AuthStatus? status, String? errorMsg, Session? session, User? user}) {
    return AuthState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      session: session ?? this.session,
      user: user ?? this.user,
    );
  }

  AuthState reset() {
    return AuthState(
        status: AuthStatus.unAuthenticated,
        errorMsg: null,
        session: null,
        user: null);
  }
}
