class LoginCubitState {}

class LoginCubitInitial extends LoginCubitState {}

class LoginCubitError extends LoginCubitState {
  String error;

  LoginCubitError({required this.error});
}

class LoginCubitSuccess extends LoginCubitState {}

class LoginCubitLoading extends LoginCubitState {}
