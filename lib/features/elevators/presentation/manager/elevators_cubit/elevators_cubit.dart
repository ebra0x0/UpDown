import 'dart:async';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevators_state.dart';

class ElevatorsCubit extends Cubit<ElevatorsState> {
  ElevatorsCubit(this._repo) : super(const ElevatorsState());
  final ElevatorsRepo _repo;
  StreamSubscription? _streamSubscription;

  void emitStreamAll() {
    if (state.status == ContentStatus.loading) {
      return;
    }
    _streamSubscription?.cancel();

    emit(state.copyWith(
        status: ContentStatus.loading,
        elevators: List.generate(2, (_) => ElevatorModel.empty())));

    _streamSubscription = _repo.streamAllElevators().listen((stream) {
      if (isClosed) return;

      stream.fold(
        (errMsg) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: errMsg.errMessage)),
        (response) {
          emit(state.copyWith(
              status: ContentStatus.loaded, elevators: response));

          if (state.buildingElevators != null &&
              state.buildingElevators!.isNotEmpty) {
            selectBuildingElevators(state.buildingElevators!.first.buildingId);
          }

          if (state.currentElevator != null) {
            selectElevator(state.currentElevator!.id);
          }
        },
      );
    });
  }

  void selectBuildingElevators(String buildingId) {
    if (state.status == ContentStatus.loading || state.elevators == null) {
      return;
    }

    emit(state.copyWith(
      buildingElevators: state.elevators
          ?.where((elevator) => elevator.buildingId == buildingId)
          .toList(),
    ));
  }

  void selectElevator(String elevatorId) {
    if (state.status == ContentStatus.loading || state.elevators == null) {
      return;
    }

    emit(state.copyWith(
        currentElevator: state.elevators
            ?.firstWhereOrNull((elevator) => elevator.id == elevatorId)));
  }

  @override
  Future<void> close() async {
    super.close();
    await _streamSubscription?.cancel();
  }
}
