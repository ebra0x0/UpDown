part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthStateInitial extends AuthState {}

final class AuthStateAuthenticated extends AuthState {
  final User user;

  AuthStateAuthenticated({required this.user});
}

final class AuthStateUnAuthenticated extends AuthState {}
