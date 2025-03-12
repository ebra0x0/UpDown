part of 'elevator_details_cubit.dart';

sealed class ElevatorDetailsState {}

final class ElevatorDetailsInitial extends ElevatorDetailsState {}

final class ElevatorDetailsLoading extends ElevatorDetailsState {}

final class ElevatorDetailsLoaded extends ElevatorDetailsState {
  final ElevatorModel elevator;
  ElevatorDetailsLoaded({required this.elevator});
}

final class ElevatorDetailsError extends ElevatorDetailsState {
  final String error;
  ElevatorDetailsError({required this.error});
}
