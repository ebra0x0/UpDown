import 'dart:async';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/maintenances/data/models/maintenance_view_model.dart';
import 'package:UpDown/features/maintenances/data/repo/maintenance_repo.dart';
import 'package:UpDown/features/maintenances/presentation/cubit/maintenance_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceCubit extends Cubit<MaintenanceState> {
  final MaintenanceRepo _repo;
  StreamSubscription? _streamSubscription;
  MaintenanceCubit(this._repo) : super(const MaintenanceState());

  void emitStreamCurrentMaintenance() {
    if (state.status == ContentStatus.loading || _streamSubscription != null) {
      return;
    }

    emit(state.copyWith(
      status: ContentStatus.loading,
      currentMaintenance: null,
    ));

    _streamSubscription = _repo.streamCurrentMaintenance().listen((event) {
      if (isClosed) return;
      event.fold(
        (failure) => emit(state.copyWith(
            status: ContentStatus.error, error: failure.errMessage)),
        (maintenance) => emit(state.copyWith(
            status: ContentStatus.loaded, currentMaintenance: maintenance)),
      );
    }, onError: (e) {
      if (isClosed) return;
      if (state.currentMaintenance != null) return;
      emit(state.copyWith(
          status: ContentStatus.error,
          error: "تعذر تحميل بيانات الصيانة الحالية"));
    });
  }

  Future<void> fetchAllMaintenances() async {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(
        status: ContentStatus.loading,
        maintenances: List.generate(
          2,
          (_) => MaintenanceViewModel.empty(),
        )));

    final result = await _repo.fetchAllMaintenances(
        offset: state.maintenances?.length ?? 0, limit: 5);

    result.fold(
      (failure) => emit(state.copyWith(
          status: ContentStatus.error, error: failure.errMessage)),
      (maintenances) => emit(state.copyWith(
          status: ContentStatus.loaded, maintenances: maintenances)),
    );
  }

  void selectMaintenance(String maintenanceId) {
    if (state.status == ContentStatus.loading || state.maintenances == null) {
      return;
    }
    emit(state.copyWith(
        currentMaintenance: state.maintenances!.firstWhereOrNull(
            (maintenance) => maintenance.data.id == maintenanceId)));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
