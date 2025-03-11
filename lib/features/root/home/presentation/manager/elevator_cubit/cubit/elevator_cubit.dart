import 'package:UpDown/features/root/home/data/model/elevator_model.dart';
import 'package:UpDown/features/root/home/data/repos/elevator_repo/elevator_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevator_state.dart';

class ElevatorCubit extends Cubit<ElevatorState> {
  ElevatorCubit(this._repo) : super(ElevatorInitial());
  final ElevatorRepo _repo;

  Future<void> getElevatorDetails({required String elevatorId}) async {
    if (elevatorId.isEmpty) {
      emit(ElevatorError(error: "يبدو أن هذا المصعد قد حذف."));
      return;
    }

    emit(ElevatorLoading());

    final result = await _repo.fetchElevatorDetails(elevatorId: elevatorId);

    result.fold(
      (errMsg) => emit(ElevatorError(error: errMsg.errMessage)),
      (response) {
        emit(ElevatorLoaded(elevator: response));
      },
    );
  }
}
