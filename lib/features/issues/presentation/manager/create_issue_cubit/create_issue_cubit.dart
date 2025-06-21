import 'dart:io';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo_imp.dart';
import 'package:UpDown/features/issues/data/models/create_issue_model.dart';
import 'package:UpDown/features/issues/data/models/media_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo_imp.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_issue_state.dart';

class CreateIssueCubit extends Cubit<CreateIssueState> {
  CreateIssueCubit(this._repo, this._elevatorRepo)
      : super(const CreateIssueState());

  final IssuesRepoImp _repo;
  final ElevatorRepoImp _elevatorRepo;

  Future<void> createIssue(BuildContext context) async {
    emit(state.copyWith(status: CreateIssueStatus.loading));

    final request = state.toRequest(context);

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
    final media = MediaModel.fromJson({
      "type": type,
      "url": file.path,
      "file": file,
    });

    emit(state.copyWith(
      status: CreateIssueStatus.selectSuccess,
      media: media,
    ));
  }

  Future<void> selectBuilding(BuildingSummaryModel building) async {
    if (building.id == state.building?.id) return;

    emit(state.copyWith(status: CreateIssueStatus.selectLoading));

    final result = await _elevatorRepo.fetchElevatorsByBuilding(building.id);

    result.fold(
      (_) => null,
      (res) {
        emit(state.copyWith(
          status: CreateIssueStatus.selectSuccess,
          building: building,
          elevators: res,
        ));
      },
    );
  }

  void selectElevator(ElevatorSummaryModel elevator) {
    emit(state.copyWith(
      status: CreateIssueStatus.selectSuccess,
      elevator: elevator,
    ));
  }

  void selectIssueType(IssueType type) {
    emit(state.copyWith(
      status: CreateIssueStatus.selectSuccess,
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
