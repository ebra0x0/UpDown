import 'dart:async';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevators_state.dart';

class ElevatorsCubit extends Cubit<ElevatorsState> {
  ElevatorsCubit(this._repo) : super(ElevatorsState());
  final ElevatorsRepo _repo;
  StreamSubscription? _byBuildingSubscription;
  StreamSubscription? _byBuildingsSubscription;
  String? currentBuildingId;
  List<String> currentBuildingIds = [];

  void emitStreamByBuilding(String buildingId) {
    if (currentBuildingId == buildingId ||
        state.status == ContentStatus.loading) {
      return;
    }

    currentBuildingId = buildingId;
    _byBuildingSubscription?.cancel();

    emit(state.copyWith(
        status: ContentStatus.loading,
        elevators: List.generate(2, (_) => ElevatorModel.empty())));

    _byBuildingSubscription =
        _repo.streamBuildingElevators(buildingId).listen((stream) {
      if (isClosed) return;

      stream.fold(
        (errMsg) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: errMsg.errMessage)),
        (response) {
          emit(state.copyWith(
              status: ContentStatus.loaded, elevators: response));
        },
      );
    }, onError: (e) {
      if (isClosed) return;
      if (state.elevators != null) return;
      emit(state.copyWith(
          status: ContentStatus.error, errorMsg: "تعذر تحميل مصاعد المبنى"));
    });
  }

  void callByBuildings(List<String> buildingIds) {
    if (state.status == ContentStatus.loading ||
        currentBuildingIds.equals(buildingIds)) {
      return;
    }

    currentBuildingIds = buildingIds;
    _byBuildingsSubscription?.cancel();

    emit(state.copyWith(
        status: ContentStatus.loading,
        elevators: List.generate(2, (_) => ElevatorModel.empty())));

    _byBuildingsSubscription =
        _repo.streamBuildingsElevators(buildingIds).listen((stream) {
      if (isClosed) return;

      stream.fold(
        (errMsg) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: errMsg.errMessage)),
        (response) {
          emit(state.copyWith(
              status: ContentStatus.loaded, elevators: response));
        },
      );
    });
  }

  @override
  Future<void> close() async {
    super.close();
    await _byBuildingSubscription?.cancel();
    await _byBuildingsSubscription?.cancel();
  }
}
