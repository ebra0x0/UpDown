import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/model/building_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buildings_cubit_state.dart';

class BuildingsCubit extends Cubit<BuildingsCubitState> {
  BuildingsCubit() : super(BuildingsCubitInitial());

  List<BuildingModel> buildings = [];
  Future<void> getBuildings() async {
    emit(BuildingsCubitLoading());
    try {
      List<BuildingModel> response = await ApiService().getBuildings();

      if (response.isEmpty) {
        emit(BuildingsCubitEmpty());
        return;
      }
      buildings = response;

      emit(BuildingsCubitSuccess(buildings: buildings));
    } catch (e) {
      emit(BuildingsCubitError(error: e.toString()));
    }
  }
}
