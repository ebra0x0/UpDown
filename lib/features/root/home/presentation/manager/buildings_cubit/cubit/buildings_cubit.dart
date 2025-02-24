import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/root/home/data/model/building_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buildings_state.dart';

class BuildingsCubit extends Cubit<BuildingsState> {
  BuildingsCubit() : super(BuildingsInitial());

  BuildingModel? buildingDetails;

  Future<void> getBuildingDetails({required String buildingId}) async {
    if (buildingDetails?.buildingId == buildingId && buildingDetails != null) {
      emit(BuildingsLoaded(building: buildingDetails!));
      return;
    }
    try {
      emit(BuildingsLoading());

      final BuildingModel response =
          await ApiService.fetchBuildingDetails(buildingId: buildingId);

      buildingDetails = response;

      emit(BuildingsLoaded(building: response));
    } catch (e) {
      emit(BuildingsError(error: e.toString()));
    }
  }
}
