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
}

// final class AuthStateInitial extends AuthState {}

// final class AuthStateAuthenticated extends AuthState {
//   final Session session;

//   AuthStateAuthenticated({required this.session});
// }

// final class AuthStateLoading extends AuthState {}

// final class AuthStateUnconfirmed extends AuthState {
//   final String email;

//   AuthStateUnconfirmed({required this.email});
// }

// final class AuthStateNewAccount extends AuthState {
//   final Session session;

//   AuthStateNewAccount({required this.session});
// }

// final class AuthStateError extends AuthState {
//   AuthStateError({required this.errorMsg});
//   final String errorMsg;
// }

// final class AuthStateUnAuthenticated extends AuthState {}
