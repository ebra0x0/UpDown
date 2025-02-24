part of 'elevator_cubit.dart';

sealed class ElevatorState {}

final class ElevatorInitial extends ElevatorState {}

final class ElevatorLoading extends ElevatorState {}

final class ElevatorLoaded extends ElevatorState {
  final ElevatorModel elevator;
  ElevatorLoaded({required this.elevator});
}

final class ElevatorError extends ElevatorState {
  final String error;
  ElevatorError({required this.error});
}
