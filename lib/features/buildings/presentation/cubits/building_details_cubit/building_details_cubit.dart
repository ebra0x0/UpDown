import 'dart:async';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'building_details_state.dart';

class BuildingDetailsCubit extends Cubit<BuildingDetailsState> {
  final BuildingsRepo _repo;
  StreamSubscription? _streamSubscription;

  BuildingDetailsCubit(this._repo) : super(BuildingDetailsState());

  void emitStreamBuilding({required String buildingId}) async {
    if (state.status == ContentStatus.loading || _streamSubscription != null) {
      return;
    }

    emit(state.copyWith(status: ContentStatus.loading));

    _streamSubscription = _repo.get(buildingId).listen((stream) {
      stream.fold(
        (e) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: e.errMessage)),
        (res) {
          emit(state.copyWith(status: ContentStatus.loaded, building: res));
        },
      );
    }, onError: (e) {
      if (state.building != null) {
        return;
      }
      emit(state.copyWith(
          status: ContentStatus.error, errorMsg: "هناك مشكلة في الاتصال"));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
