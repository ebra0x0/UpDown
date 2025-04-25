import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevator_details_state.dart';

class ElevatorDetailsCubit extends Cubit<ElevatorDetailsState> {
  ElevatorDetailsCubit(this._repo) : super(ElevatorDetailsInitial());

  final ElevatorRepo _repo;

  ElevatorModel? elevator;

  Future<void> call({required String elevatorId}) async {
    if (elevator != null && elevator!.id == elevatorId) {
      emit(ElevatorDetailsLoaded(elevator: elevator!));
    }

    emit(ElevatorDetailsLoading());
    final result = await _repo.fetchElevatorDetails(elevatorId);

    result.fold(
      (errMsg) => emit(ElevatorDetailsError(error: errMsg.errMessage)),
      (response) {
        if (response == null) {
          emit(ElevatorDetailsEmpty());
          return;
        }
        elevator = response;
        emit(ElevatorDetailsLoaded(elevator: response));
      },
    );
  }
}
