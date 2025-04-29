import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buildings_state.dart';

class BuildingsCubit extends Cubit<BuildingsState> {
  BuildingsCubit(this._repo) : super(BuildingsInitial());
  final BuildingsRepo _repo;

  List<BuildingSummaryModel>? buildings;

  Future<void> call() async {
    if (state is BuildingsLoading) return;
    if (buildings != null) {
      emit(BuildingsLoaded(buildings: buildings!));
      return;
    }

    emit(BuildingsLoading());
    final result = await _repo.fetchBuildings();

    result.fold(
      (errMsg) => emit(BuildingsError(error: errMsg.errMessage)),
      (response) {
        if (response == null) {
          emit(BuildingsEmpty());
          return;
        }
        buildings = response;
        emit(BuildingsLoaded(buildings: response));
      },
    );
  }
}
