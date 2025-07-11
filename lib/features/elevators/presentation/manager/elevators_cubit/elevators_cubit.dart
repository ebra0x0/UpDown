import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_response_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'elevators_state.dart';

class ElevatorsCubit extends Cubit<ElevatorsState> {
  ElevatorsCubit(this._repo) : super(ElevatorsState());
  final ElevatorsRepo _repo;

  final Set<ElevatorSummaryResponseModel> _elevators = {};

  Future<void> callByBuilding({required String buildingId}) async {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(status: ContentStatus.loading));
    // get the exist elevators if already loaded
    if (_elevators.isNotEmpty) {
      final existingElevators = _elevators
          .where((elevator) => elevator.buildingId == buildingId)
          .toList();

      if (existingElevators.isNotEmpty) {
        emit(state.copyWith(
            status: ContentStatus.loaded, elevators: existingElevators));
        return;
      }
    }

    final result = await _repo.fetchElevatorsByBuilding(buildingId);

    result.fold(
      (errMsg) => emit(state.copyWith(
          status: ContentStatus.error, errorMsg: errMsg.errMessage)),
      (response) {
        _elevators.addAll(response);
        emit(state.copyWith(status: ContentStatus.loaded, elevators: response));
      },
    );
  }

  Future<void> callByBuildings(List<String> buildingIds) async {
    if (state.status == ContentStatus.loading) return;
    emit(state.copyWith(status: ContentStatus.loading));
    // get the exist elevators if already loaded
    if (_elevators.isNotEmpty) {
      final existingElevators = _elevators
          .where((elevator) => buildingIds.contains(elevator.buildingId))
          .toList();

      final hasAllBuildings = buildingIds.every((buildingId) {
        return _elevators.any((elevator) => elevator.buildingId == buildingId);
      });

      if (existingElevators.isNotEmpty && hasAllBuildings) {
        emit(state.copyWith(
            status: ContentStatus.loaded, elevators: existingElevators));
        return;
      }
    }

    final result = await _repo.fetchElevatorsByBuildings(buildingIds);

    result.fold(
      (errMsg) => emit(state.copyWith(
          status: ContentStatus.error, errorMsg: errMsg.errMessage)),
      (response) {
        _elevators.addAll(response);
        emit(state.copyWith(status: ContentStatus.loaded, elevators: response));
      },
    );
  }
}
