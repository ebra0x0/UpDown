part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthStateInitial extends AuthState {}

final class AuthStateAuthenticated extends AuthState {
  final Session session;

  AuthStateAuthenticated({required this.session});
}

final class AuthStateLoading extends AuthState {}

final class AuthStateUnconfirmed extends AuthState {
  final String email;

  AuthStateUnconfirmed({required this.email});
}

final class AuthStateError extends AuthState {
  AuthStateError({required this.errorMsg});
  final String errorMsg;
}

final class AuthStateUnAuthenticated extends AuthState {}
