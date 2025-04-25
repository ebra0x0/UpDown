part of 'elevators_cubit.dart';

sealed class ElevatorsState {}

final class ElevatorsInitial extends ElevatorsState {}

final class ElevatorsLoading extends ElevatorsState {}

final class ElevatorsLoaded extends ElevatorsState {
  final List<ElevatorSummaryModel> elevators;
  ElevatorsLoaded({required this.elevators});
}

final class ElevatorsEmpty extends ElevatorsState {}

final class ElevatorsError extends ElevatorsState {
  final String error;
  ElevatorsError({required this.error});
}
