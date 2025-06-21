import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buildings_state.dart';

class BuildingsCubit extends Cubit<BuildingsState> {
  BuildingsCubit(this._repo) : super(BuildingsState());
  final BuildingsRepo _repo;

  Set<BuildingSummaryModel> buildings = {};

  Future<void> call() async {
    if (state.status == BuildingsStates.loading) return;

    if (buildings.isNotEmpty) {
      emit(state.copyWith(
          status: BuildingsStates.loaded, buildings: buildings.toList()));
      return;
    }

    emit(state.copyWith(status: BuildingsStates.loading));

    final result = await _repo.fetchBuildings();

    result.fold(
      (errMsg) => emit(state.copyWith(
          status: BuildingsStates.error, errorMsg: errMsg.errMessage)),
      (response) {
        buildings.addAll(response);
        emit(state.copyWith(
            status: BuildingsStates.loaded, buildings: response));
      },
    );
  }
}
