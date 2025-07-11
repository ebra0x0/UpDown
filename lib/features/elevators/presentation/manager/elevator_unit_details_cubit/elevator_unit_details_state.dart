part of 'elevator_unit_details_cubit.dart';

class ElevatorUnitDetailsState {
  final ContentStatus status;
  final UnitModel? unit;
  final String? errorMsg;

  ElevatorUnitDetailsState({
    this.status = ContentStatus.initial,
    this.unit,
    this.errorMsg,
  });

  ElevatorUnitDetailsState copyWith({
    ContentStatus? status,
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
