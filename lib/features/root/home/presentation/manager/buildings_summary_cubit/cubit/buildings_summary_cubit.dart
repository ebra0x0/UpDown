import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/repos/home_repo/home_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buildings_summary_state.dart';

class BuildingsSummaryCubit extends Cubit<BuildingsSummaryState> {
  BuildingsSummaryCubit(this._repo) : super(BuildingsSummaryInitial());
  final HomeRepo _repo;

  Future<void> fetchBuildingsSummary(BuildContext context) async {
    final List<BuildingSummaryModel>? userBuildings =
        BlocProvider.of<UserDataCubit>(context).userData?.buildings;

    if (userBuildings != null && userBuildings.isNotEmpty) {
      emit(BuildingsSummaryLoaded(buildingsSummary: userBuildings));
      return;
    }

    emit(BuildingsSummaryLoading());

    final result = await _repo.fetchBuildingsSummary();
    result.fold(
      (errMsg) => emit(BuildingsSummaryError(error: errMsg.errMessage)),
      (response) {
        emit(BuildingsSummaryLoaded(buildingsSummary: response));
      },
    );
  }
}
