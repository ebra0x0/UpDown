import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevator_units_state.dart';

class ElevatorUnitsCubit extends Cubit<ElevatorUnitsState> {
  final ElevatorRepo _repo;

  ElevatorUnitsCubit(this._repo) : super(ElevatorUnitsState());

  Future<void> call(String elevatorId) async {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(status: ContentStatus.loading));

    final unitsEither = await _repo.fetchElevatorUnits(elevatorId);

    unitsEither.fold(
        (failure) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: failure.errMessage)),
        (units) => emit(
              state.copyWith(units: units, status: ContentStatus.loaded),
            ));
  }
}
