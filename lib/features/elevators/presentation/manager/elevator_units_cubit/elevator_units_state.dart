part of 'elevator_units_cubit.dart';

class ElevatorUnitsState {
  final ContentStatus status;
  final String? errorMsg;
  final List<UnitModel>? units;

  const ElevatorUnitsState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.units,
  });

  ElevatorUnitsState copyWith({
    ContentStatus? status,
    String? errorMsg,
    List<UnitModel>? units,
  }) {
    return ElevatorUnitsState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      units: units ?? this.units,
    );
  }
}
