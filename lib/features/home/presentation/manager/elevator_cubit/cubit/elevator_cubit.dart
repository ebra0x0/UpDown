import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/home/data/model/elevator_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevator_state.dart';

class ElevatorCubit extends Cubit<ElevatorState> {
  ElevatorCubit() : super(ElevatorInitial());

  ElevatorModel? elevator;

  void getElevatorDetails({required String elevatorId}) async {
    try {
      emit(ElevatorLoading());

      final ElevatorModel response =
          await ApiService().fetchElevatorDetails(elevatorId: elevatorId);

      elevator = response;

      emit(ElevatorLoaded(elevator: response));
    } catch (e) {
      emit(ElevatorError(error: e.toString()));
    }
  }
}
