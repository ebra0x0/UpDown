import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/root/home/data/model/building_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buildings_state.dart';

class BuildingsCubit extends Cubit<BuildingsState> {
  BuildingsCubit() : super(BuildingsInitial());

  BuildingModel? buildingDetails;

  Future<void> getBuildingDetails({required String buildingId}) async {
    if (buildingId.isEmpty) {
      emit(BuildingsError(error: "معرّف المبنى غير صالح"));
      return;
    }

    if (buildingDetails?.buildingId == buildingId) {
      emit(BuildingsLoaded(building: buildingDetails!));
      return;
    }

    try {
      emit(BuildingsLoading());

      final result =
          await ApiService.fetchBuildingDetails(buildingId: buildingId);

      result.fold(
        (errMsg) => emit(BuildingsError(error: errMsg)),
        (response) {
          buildingDetails = response;
          emit(BuildingsLoaded(building: response));
        },
      );
    } catch (e) {
      emit(BuildingsError(error: "حدث خطأ غير متوقع : ${e.toString()}"));
    }
  }
}
