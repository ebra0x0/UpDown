part of 'elevators_cubit.dart';

class ElevatorsState {
  final ContentStatus status;
  final String? errorMsg;
  final List<ElevatorModel>? elevators;
  final List<ElevatorModel>? buildingElevators;
  final ElevatorModel? currentElevator;

  ElevatorsState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.elevators,
    this.buildingElevators,
    this.currentElevator,
  });

  ElevatorsState copyWith({
    ContentStatus? status,
    String? errorMsg,
    List<ElevatorModel>? elevators,
    List<ElevatorModel>? buildingElevators,
    ElevatorModel? currentElevator,
  }) {
    return ElevatorsState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      elevators: elevators ?? this.elevators,
      buildingElevators: buildingElevators ?? this.buildingElevators,
      currentElevator: currentElevator ?? this.currentElevator,
    );
  }
}
