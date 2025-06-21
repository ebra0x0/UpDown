part of 'elevator_unit_details_cubit.dart';

enum UnitsStates { initial, loading, empty, loaded, error }

class ElevatorUnitDetailsState {
  final UnitsStates status;
  final UnitModel? unit;
  final String? errorMsg;

  ElevatorUnitDetailsState({
    this.status = UnitsStates.initial,
    this.unit,
    this.errorMsg,
  });

  ElevatorUnitDetailsState copyWith({
    UnitsStates? status,
    UnitModel? unit,
    String? errorMsg,
  }) {
    return ElevatorUnitDetailsState(
      status: status ?? this.status,
      unit: unit ?? this.unit,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
