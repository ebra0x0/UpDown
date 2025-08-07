import 'dart:async';

import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevator_details_state.dart';

class ElevatorDetailsCubit extends Cubit<ElevatorDetailsState> {
  final ElevatorsRepo _repo;

  late final StreamSubscription _subscription;

  ElevatorDetailsCubit(this._repo) : super(ElevatorDetailsState());

  void call({required String elevatorId}) {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(
        status: ContentStatus.loading, elevator: ElevatorModel.empty()));

    _subscription = _repo.streamElevatorDetails(elevatorId).listen((stream) {
      if (isClosed) return;
      stream.fold(
        (errMsg) => emit(state.copyWith(
          status: ContentStatus.error,
          errorMsg: errMsg.errMessage,
        )),
        (response) {
          emit(state.copyWith(
            status: ContentStatus.loaded,
            elevator: response,
          ));
        },
      );
    });
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    super.close();
  }
}
