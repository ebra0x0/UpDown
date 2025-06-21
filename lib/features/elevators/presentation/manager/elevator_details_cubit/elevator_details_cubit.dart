import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevator_details_state.dart';

class ElevatorDetailsCubit extends Cubit<ElevatorDetailsState> {
  final ElevatorRepo _repo;

  ElevatorDetailsCubit(this._repo) : super(ElevatorDetailsState());

  Future<void> call({required String elevatorId}) async {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(status: ContentStatus.loading));

    final result = await _repo.fetchElevatorDetails(elevatorId);

    result.fold(
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
  }
}
