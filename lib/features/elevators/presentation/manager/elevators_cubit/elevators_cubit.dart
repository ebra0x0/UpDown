import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevators_state.dart';

class ElevatorsCubit extends Cubit<ElevatorsState> {
  ElevatorsCubit(this._repo) : super(ElevatorsInitial());
  final ElevatorRepo _repo;

  List<ElevatorSummaryModel>? elevators;

  Future<void> call({required String buildingId}) async {
    if (elevators != null && buildingId == elevators![0].buildingId) {
      emit(ElevatorsLoaded(elevators: elevators!));
    }

    emit(ElevatorsLoading());

    final result = await _repo.fetchElevators(buildingId);

    result.fold(
      (errMsg) => emit(ElevatorsError(error: errMsg.errMessage)),
      (response) {
        if (response == null) {
          emit(ElevatorsEmpty());
          return;
        }
        elevators = response;
        emit(ElevatorsLoaded(elevators: response));
      },
    );
  }
}
