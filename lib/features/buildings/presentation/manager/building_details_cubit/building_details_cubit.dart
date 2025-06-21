import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'building_details_state.dart';

class BuildingDetailsCubit extends Cubit<BuildingDetailsState> {
  BuildingDetailsCubit(this._repo) : super(BuildingDetailsState());

  final BuildingsRepoImp _repo;

  Future<void> call({required String buildingId}) async {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(status: ContentStatus.loading));

    final result = await _repo.fetchBuildingDetails(buildingId);

    result.fold(
        (errMsg) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: errMsg.errMessage)),
        (response) => emit(
            state.copyWith(status: ContentStatus.loaded, building: response)));
  }
}
