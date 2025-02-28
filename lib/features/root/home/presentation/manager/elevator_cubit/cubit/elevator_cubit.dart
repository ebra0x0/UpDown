import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/root/home/data/model/elevator_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevator_state.dart';

class ElevatorCubit extends Cubit<ElevatorState> {
  ElevatorCubit() : super(ElevatorInitial());

  ElevatorModel? elevator;

  Future<void> getElevatorDetails({required String elevatorId}) async {
    if (elevatorId.isEmpty) {
      emit(ElevatorError(error: "معرّف المصعد غير صالح"));
      return;
    }

    if (elevator?.elevatorId == elevatorId) {
      emit(ElevatorLoaded(elevator: elevator!));
      return;
    }

    try {
      emit(ElevatorLoading());

      final result =
          await ApiService.fetchElevatorDetails(elevatorId: elevatorId);

      result.fold(
        (errMsg) => emit(ElevatorError(error: errMsg)),
        (response) {
          elevator = response;
          emit(ElevatorLoaded(elevator: response));
        },
      );
    } catch (e) {
      emit(ElevatorError(error: "حدث خطأ غير متوقع"));
    }
  }
}
