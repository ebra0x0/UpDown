import 'package:UpDown/features/root/create_issue/data/repos/create_issue_repo_imp.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_issue_state.dart';

class CreateIssueCubit extends Cubit<CreateIssueState> {
  CreateIssueCubit(
    this._repo, {
    required this.buildings,
    required this.elevators,
  }) : super(CreateIssueInitial()) {
    selectedBuilding = _repo.selectedBuilding;
    selectedElevator = _repo.selectedElevator;
    issueType = _repo.issueType;
    description = _repo.description;
  }
  final CreateIssueRepoImp _repo;

  final List<BuildingSummaryModel> buildings;
  final List<ElevatorSummaryModel> elevators;

  BuildingSummaryModel? selectedBuilding;
  ElevatorSummaryModel? selectedElevator;
  String? issueType;
  String? description;

  Future<void> createIssue() async {
    emit(CreateIssueLoading());

    final result = await _repo.createIssue();

    result.fold((errMsg) => emit(CreateIssueError(error: errMsg.errMessage)),
        (response) {
      emit(CreateIssueSuccess());
      _repo.reset();
      emit(CreateIssueInitial());
    });
  }

  void selectBuilding(BuildingSummaryModel building) {
    final currentState = state is SelectSuccess ? state as SelectSuccess : null;
    _repo.selectedBuilding = building;
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
    _repo.selectedElevator = elevator;
    emit(SelectSuccess(
      building: currentState?.building,
      issueType: currentState?.issueType,
      elevator: elevator,
    ));
  }

  void selectIssueType(String value) {
    final currentState = state is SelectSuccess ? state as SelectSuccess : null;
    issueType = value;
    _repo.issueType = value;
    emit(SelectSuccess(
        building: currentState?.building,
        elevator: currentState?.elevator,
        issueType: value));
  }

  void updateDescription(String value) {
    description = value;
    _repo.description = value;
  }
}
