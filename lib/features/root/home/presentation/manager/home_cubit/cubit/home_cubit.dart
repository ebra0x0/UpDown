import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/repos/home_repo/home_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(HomeInitial());
  final HomeRepo _repo;

  Future<void> fetchBuildingsSummary(BuildContext context) async {
    final List<BuildingSummaryModel>? userBuildings =
        BlocProvider.of<UserDataCubit>(context).userData?.buildings;

    if (userBuildings != null && userBuildings.isNotEmpty) {
      emit(HomeLoaded(buildingsSummary: userBuildings));
      return;
    }

    emit(HomeLoading());

    final result = await _repo.fetchBuildingsSummary();
    result.fold(
      (errMsg) => emit(HomeError(error: errMsg.errMessage)),
      (response) {
        emit(HomeLoaded(buildingsSummary: response));
      },
    );
  }
}
