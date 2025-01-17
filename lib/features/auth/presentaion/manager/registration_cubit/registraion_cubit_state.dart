class RegistraionCubitState {}

class RegistraionCubitInitial extends RegistraionCubitState {}

class RegistraionCubitError extends RegistraionCubitState {
  String error;
  RegistraionCubitError({required this.error});
}

class RegistraionCubitSuccess extends RegistraionCubitState {}

class RegistraionCubitLoading extends RegistraionCubitState {}
