import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'building_details_state.dart';

class BuildingDetailsCubit extends Cubit<BuildingDetailsState> {
  BuildingDetailsCubit(this._repo) : super(BuildingDetailsInitial());

  final BuildingsRepoImp _repo;

  BuildingModel? building;

  Future<void> call({required String buildingId}) async {
    if (building != null && building!.id == buildingId) {
      emit(BuildingDetailsLoaded(building: building!));
      return;
    }

    emit(BuildingDetailsLoading());
    final result = await _repo.fetchBuildingDetails(
      buildingId,
    );

    result.fold(
      (errMsg) => emit(BuildingDetailsError(error: errMsg.errMessage)),
      (response) {
        if (response == null) {
          emit(BuildingDetailsEmpty());
          return;
        }
        building = response;
        emit(BuildingDetailsLoaded(building: response));
      },
    );
  }
}
