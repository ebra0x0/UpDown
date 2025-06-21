import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevator_unit_details_state.dart';

class ElevatorUnitDetailsCubit extends Cubit<ElevatorUnitDetailsState> {
  final ElevatorRepo _repo;
  ElevatorUnitDetailsCubit(this._repo) : super(ElevatorUnitDetailsState());

  Future<void> call({required String unitId}) async {
    if (state.status == UnitsStates.loading) return;

    emit(state.copyWith(status: UnitsStates.loading));

    final unitEither = await _repo.fetchUnitDetails(unitId);

    unitEither.fold(
      (failure) => emit(state.copyWith(errorMsg: failure.errMessage)),
      (unit) => emit(
        state.copyWith(unit: unit, status: UnitsStates.loaded),
      ),
    );
  }
}
