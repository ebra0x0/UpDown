import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<BuildingSummaryModel> buildingsSummary = [];

  Future<void> fetchBuildingsSummary(BuildContext context) async {
    try {
      final List<BuildingSummaryModel>? userBuildings =
          BlocProvider.of<UserDataCubit>(context).userData?.buildings;

      if (userBuildings != null && userBuildings.isNotEmpty) {
        emit(HomeLoaded(buildingsSummary: userBuildings));
        return;
      }

      emit(HomeLoading());

      final result = await ApiService.fetchBuildingsSummary();
      result.fold(
        (errMsg) => emit(HomeError(error: errMsg)),
        (response) {
          buildingsSummary = response;
          emit(HomeLoaded(buildingsSummary: response));
        },
      );
    } catch (e) {
      emit(HomeError(error: "حدث خطأ غير متوقع"));
    }
  }
}
