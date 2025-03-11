part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthStateInitial extends AuthState {}

final class AuthStateAuthenticated extends AuthState {
  final User user;

  AuthStateAuthenticated({required this.user});
}

final class AuthStateLoading extends AuthState {}

final class AuthStateError extends AuthState {
  AuthStateError({required this.errorMsg});
  final String errorMsg;
}

final class AuthStateUnAuthenticated extends AuthState {}
