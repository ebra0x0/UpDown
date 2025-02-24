import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_issue_state.dart';

class CreateIssueCubit extends Cubit<CreateIssueState> {
  CreateIssueCubit({
    required this.buildings,
    required this.elevators,
  }) : super(CreateIssueInitial());

  final List<BuildingSummaryModel> buildings;
  final List<ElevatorSummaryModel> elevators;

  BuildingSummaryModel? selectedBuilding;
  ElevatorSummaryModel? selectedElevator;
  String? issueType;
  String? description;

  Future<void> createIssue() async {
    try {
      emit(CreateIssueLoading());

      IssueModel issueModel = IssueModel.fromJson({
        "issue_type": issueType,
        "description": description,
        "building_id": selectedBuilding?.buildingId,
        "elevator_id": selectedElevator?.elevatorId,
      });

      await ApiService.createIssue(issueModel);

      emit(CreateIssueSuccess());
    } catch (e) {
      print(e);
      emit(CreateIssueError(error: e.toString()));
    }
  }

  void selectBuilding(BuildingSummaryModel building) {
    final currentState = state is SelectSuccess ? state as SelectSuccess : null;
    selectedBuilding = building;
    emit(SelectSuccess(
      building: building,
      elevator: currentState?.elevator,
      issueType: currentState?.issueType,
    ));
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
    final currentState = state is SelectSuccess ? state as SelectSuccess : null;
    description = value;
    emit(SelectSuccess(
        building: currentState?.building,
        elevator: currentState?.elevator,
        issueType: currentState?.issueType,
        description: value));
  }
}
