part of 'elevators_cubit.dart';

enum ElevatorsStates { initial, loading, loaded, error }

class ElevatorsState {
  final ElevatorsStates status;
  final String? errorMsg;
  final List<ElevatorSummaryModel>? elevators;

  ElevatorsState({
    this.status = ElevatorsStates.initial,
    this.errorMsg,
    this.elevators,
  });

  ElevatorsState copyWith({
    ElevatorsStates? status,
    String? errorMsg,
    List<ElevatorSummaryModel>? elevators,
  }) {
    return ElevatorsState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      elevators: elevators ?? this.elevators,
    );
  }
}
