import 'package:UpDown/features/root/home/data/model/building_model.dart';
import 'package:UpDown/features/root/home/data/repos/building_repo/building_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'building_details_state.dart';

class BuildingDetailsCubit extends Cubit<BuildingDetailsState> {
  BuildingDetailsCubit(this._repo) : super(BuildingDetailsInitial());
  final BuildingRepo _repo;

  Future<void> getBuildingDetails({required String buildingId}) async {
    if (buildingId.isEmpty) {
      emit(BuildingDetailsError(error: "يبدو أن هذا المبنى قد حذف."));
      return;
    }

    emit(BuildingDetailsLoading());

    final result = await _repo.fetchBuildingDetails(
      buildingId: buildingId,
    );

    result.fold(
      (errMsg) => emit(BuildingDetailsError(error: errMsg.errMessage)),
      (response) {
        emit(BuildingDetailsLoaded(building: response));
      },
    );
  }
}
