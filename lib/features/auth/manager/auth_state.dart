part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unAuthenticated,
  error,
  unconfirmed,
  newAccount
}

class AuthState {
  final AuthStatus status;
  final String? errorMsg;
  final Session? session;
  final String? email;

  AuthState({
    this.status = AuthStatus.initial,
    this.errorMsg,
    this.session,
    this.email,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMsg,
    Session? session,
    String? email,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      session: session ?? this.session,
      email: email ?? this.email,
    );
  }

  AuthState reset() {
    return AuthState(
      status: AuthStatus.initial,
      errorMsg: null,
      session: null,
      email: null,
    );
  }
}
