import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/home/data/model/building_model.dart';
import 'package:UpDown/features/home/data/model/building_summary_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<BuildingSummary> buildingsSummary = [];
  BuildingModel? buildingDetails;

  Future<void> fetchBuildingsSummary() async {
    if (buildingsSummary.isNotEmpty) {
      emit(HomeLoaded(buildingsSummary: buildingsSummary));
      return;
    }
    try {
      emit(HomeLoading());
      List<BuildingSummary> response =
          await ApiService().fetchBuildingsSummary();

      buildingsSummary = response;

      emit(HomeLoaded(buildingsSummary: response));
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }
}
