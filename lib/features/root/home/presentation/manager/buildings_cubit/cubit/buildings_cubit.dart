import 'package:UpDown/features/root/home/data/model/building_model.dart';
import 'package:UpDown/features/root/home/data/repos/building_repo/building_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buildings_state.dart';

class BuildingsCubit extends Cubit<BuildingsState> {
  BuildingsCubit(this._repo) : super(BuildingsInitial());
  final BuildingRepo _repo;

  Future<void> getBuildingDetails({required String buildingId}) async {
    if (buildingId.isEmpty) {
      emit(BuildingsError(error: "يبدو أن هذا المبنى قد حذف."));
      return;
    }

    emit(BuildingsLoading());

    final result = await _repo.fetchBuildingDetails(
      buildingId: buildingId,
    );

    result.fold(
      (errMsg) => emit(BuildingsError(error: errMsg.errMessage)),
      (response) {
        emit(BuildingsLoaded(building: response));
      },
    );
  }
}
