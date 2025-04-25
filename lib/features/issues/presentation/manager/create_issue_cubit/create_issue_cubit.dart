import 'dart:io';

import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/function/media_compressor.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/data/models/media_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo_imp.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_issue_state.dart';

class CreateIssueCubit extends Cubit<CreateIssueState> {
  CreateIssueCubit(
    this._repo,
  ) : super(CreateIssueInitial());

  final IssuesRepoImp _repo;

  List<BuildingSummaryModel>? buildings;
  List<ElevatorSummaryModel>? elevators;

  MediaModel? media;
  BuildingSummaryModel? selectedBuilding;
  ElevatorSummaryModel? selectedElevator;
  String? issueType;
  String? description;

  Future<void> createIssue() async {
    emit(CreateIssueLoading());

    if (media != null) {
      // Compress file
      final File? compressedFile =
          await prepareMediaFile(media!.file!, media!.type);

      media = media?.copyWith(file: compressedFile, url: compressedFile?.path);
    }

    final IssueModel issueModel = IssueModel.fromJson({
      "media": media,
      "building_name": selectedBuilding?.name,
      "elevator_name": selectedElevator?.name,
      "issue_type": issueType,
      "description": description,
      "building_id": selectedBuilding?.id,
      "elevator_id": selectedElevator?.id,
    });

    final result = await _repo.createIssue(issueModel);

    result.fold((errMsg) => emit(CreateIssueError(error: errMsg.errMessage)),
        (response) => emit(CreateIssueSuccess()));
  }

  void selectMedia({required File file, required MediaType type}) {
    final currentState = state is SelectSuccess ? state as SelectSuccess : null;
    media = MediaModel.fromJson({
      "type": type,
      "url": file.path,
      "file": file,
    });

    emit(SelectSuccess(
      media: media,
      building: currentState?.building,
      elevator: currentState?.elevator,
      issueType: currentState?.issueType,
    ));
  }

  Future<void> selectBuilding(BuildingSummaryModel building) async {
    final currentState = state is SelectSuccess ? state as SelectSuccess : null;
    selectedBuilding = building;

    final res = await _repo.fetchElevators(building.id);

    res.fold((failure) => null, (res) {
      elevators = res;
      emit(SelectSuccess(
        building: building,
        elevator: currentState?.elevator,
        issueType: currentState?.issueType,
      ));
    });
  }

  void selectElevator(ElevatorSummaryModel elevator) {
    final currentState = state is SelectSuccess ? state as SelectSuccess : null;
    selectedElevator = elevator;

    emit(SelectSuccess(
      building: currentState?.building,
      issueType: currentState?.issueType,
      elevator: elevator,
    ));
  }

  void selectIssueType(String value) {
    final currentState = state is SelectSuccess ? state as SelectSuccess : null;
    issueType = value;

    emit(SelectSuccess(
        building: currentState?.building,
        elevator: currentState?.elevator,
        issueType: value));
  }

  void updateDescription(String value) {
    description = value;
  }
}
