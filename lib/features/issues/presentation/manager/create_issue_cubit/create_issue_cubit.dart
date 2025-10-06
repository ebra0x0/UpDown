import 'dart:async';
import 'dart:io';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/model/media_models/media_request_model.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_issue_state.dart';

class CreateIssueCubit extends Cubit<CreateIssueState> {
  final IssuesRepo _repo;
  final ElevatorsRepo _elevatorsRepo;
  StreamSubscription? _elevatorsSubscription;

  final descriptionController = TextEditingController();

  CreateIssueCubit(this._repo, this._elevatorsRepo)
      : super(const CreateIssueState());

  Future<void> create() async {
    emit(state.copyWith(status: CreateIssueStatus.loading));

    final IssueRequestModel request = state.toRequestModel();

    final result = await _repo.create(request);
    if (isClosed) return;

    result.fold(
      (err) => emit(state.copyWith(
        status: CreateIssueStatus.error,
        error: err.errMessage,
      )),
      (_) {
        emit(state.copyWith(status: CreateIssueStatus.success));
        descriptionController.clear();
        reset();
      },
    );
  }

  void selectMedia({required File file, required MediaType type}) {
    final media = MediaRequestModel(
      type: type,
      url: file.path,
      file: file,
    );

    emit(state.copyWith(
      status: CreateIssueStatus.selected,
      mediaList: [...state.mediaList, media],
    ));
  }

  void selectBuilding(BuildingModel building) {
    if (building.id == state.selectedBuilding?.id ||
        state.status == CreateIssueStatus.loading) {
      return;
    }

    emit(state.copyWith(status: CreateIssueStatus.selectLoading));

    _elevatorsSubscription =
        _elevatorsRepo.streamAllElevators().listen((stream) {
      if (isClosed) return;
      stream.fold(
        (err) => emit(state.copyWith(
          status: CreateIssueStatus.error,
          error: err.errMessage,
        )),
        (elevators) {
          final buildingElevators = elevators
              .where((elevator) => elevator.buildingId == building.id)
              .toList();

          emit(state.copyWith(
            status: CreateIssueStatus.selected,
            selectedBuilding: building,
            elevatorsList: buildingElevators,
          ));
        },
      );
    }, onError: (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: CreateIssueStatus.error,
        error: e.toString(),
      ));
    });
  }

  void selectElevator(ElevatorModel elevator) {
    emit(state.copyWith(
      status: CreateIssueStatus.selected,
      selectedElevator: elevator,
    ));
  }

  void selectIssueType(IssueType type) {
    emit(state.copyWith(
      status: CreateIssueStatus.selected,
      issueType: type,
    ));
  }

  void setDescription(String desc) {
    emit(state.copyWith(
      description: desc,
    ));
  }

  void reset() {
    emit(state.reset());
  }

  @override
  Future<void> close() {
    _elevatorsSubscription?.cancel();
    descriptionController.dispose();
    return super.close();
  }
}
