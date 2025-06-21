part of 'elevator_details_cubit.dart';

class ElevatorDetailsState {
  final ContentStatus status;
  final String? errorMsg;
  final ElevatorModel? elevator;

  ElevatorDetailsState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.elevator,
  });

  ElevatorDetailsState copyWith({
    ContentStatus? status,
    String? errorMsg,
    ElevatorModel? elevator,
  }) {
    return ElevatorDetailsState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      elevator: elevator ?? this.elevator,
    );
  }
}
