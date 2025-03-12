import 'package:UpDown/features/root/home/data/model/elevator_model.dart';
import 'package:UpDown/features/root/home/data/repos/elevator_repo/elevator_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevator_details_state.dart';

class ElevatorDetailsCubit extends Cubit<ElevatorDetailsState> {
  ElevatorDetailsCubit(this._repo) : super(ElevatorDetailsInitial());
  final ElevatorRepo _repo;

  Future<void> getElevatorDetails({required String elevatorId}) async {
    if (elevatorId.isEmpty) {
      emit(ElevatorDetailsError(error: "يبدو أن هذا المصعد قد حذف."));
      return;
    }

    emit(ElevatorDetailsLoading());

    final result = await _repo.fetchElevatorDetails(elevatorId: elevatorId);

    result.fold(
      (errMsg) => emit(ElevatorDetailsError(error: errMsg.errMessage)),
      (response) {
        emit(ElevatorDetailsLoaded(elevator: response));
      },
    );
  }
}
