import 'dart:io';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/model/media_models/media_request_model.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/elevators/data/repo/elevators_repo.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_issue_state.dart';

class CreateIssueCubit extends Cubit<CreateIssueState> {
  CreateIssueCubit(this._repo, this._elevatorRepo)
      : super(const CreateIssueState());

  final IssuesRepo _repo;
  final ElevatorsRepo _elevatorRepo;

  Future<void> create() async {
    emit(state.copyWith(status: CreateIssueStatus.loading));

    final IssueRequestModel request = state.toRequestModel();

    final result = await _repo.create(request);

    result.fold(
      (err) => emit(state.copyWith(
        status: CreateIssueStatus.error,
        error: err.errMessage,
      )),
      (_) {
        emit(state.copyWith(status: CreateIssueStatus.success));
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

  Future<void> selectBuilding(BuildingModel building) async {
    if (building.id == state.building?.id) return;

    emit(state.copyWith(status: CreateIssueStatus.selectLoading));

    final result = await _elevatorRepo.fetchElevatorsByBuilding(building.id);

    result.fold(
      (err) => emit(state.copyWith(
        status: CreateIssueStatus.error,
        error: err.errMessage,
      )),
      (res) {
        emit(state.copyWith(
          status: CreateIssueStatus.selected,
          building: building,
          elevators: res,
        ));
      },
    );
  }

  void selectElevator(ElevatorSummaryResponseModel elevator) {
    emit(state.copyWith(
      status: CreateIssueStatus.selected,
      elevator: elevator,
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
}
