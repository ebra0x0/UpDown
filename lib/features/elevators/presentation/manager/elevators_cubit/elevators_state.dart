part of 'elevators_cubit.dart';

class ElevatorsState {
  final ContentStatus status;
  final String? errorMsg;
  final List<ElevatorSummaryResponseModel>? elevators;

  ElevatorsState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.elevators,
  });

  ElevatorsState copyWith({
    ContentStatus? status,
    String? errorMsg,
    List<ElevatorSummaryResponseModel>? elevators,
  }) {
    return ElevatorsState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      elevators: elevators ?? this.elevators,
    );
  }
}
