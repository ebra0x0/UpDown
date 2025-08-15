import 'dart:async';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'buildings_state.dart';

class BuildingsCubit extends Cubit<BuildingsState> {
  BuildingsCubit(this._repo) : super(BuildingsState());
  final BuildingsRepo _repo;

  StreamSubscription? _streamSubscription;

  void emitStreamBuildings() async {
    if (state.status == ContentStatus.loading || _streamSubscription != null) {
      return;
    }

    emit(state.copyWith(
      status: ContentStatus.loading,
      buildings: List.generate(
        2,
        (_) => BuildingModel.empty(),
      ),
    ));

    _streamSubscription = _repo.getAll().listen((stream) {
      if (isClosed) return;
      stream.fold(
        (e) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: e.errMessage)),
        (res) {
          if (res.isEmpty) {
            emit(state.copyWith(status: ContentStatus.empty, buildings: []));
            return;
          }

          emit(state.copyWith(status: ContentStatus.loaded, buildings: res));
        },
      );
    }, onError: (e) {
      if (isClosed) return;
      if (state.buildings != null) return;
      emit(state.copyWith(
          status: ContentStatus.error, errorMsg: "تعذر تحميل المباني"));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
