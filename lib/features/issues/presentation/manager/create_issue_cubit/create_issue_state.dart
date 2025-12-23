part of 'create_issue_cubit.dart';

enum CreateIssueStatus {
  initial,
  loading,
  error,
  success,
  selectLoading,
  selected,
}

class CreateIssueState {
  final CreateIssueStatus status;
  final String? error;
  final List<MediaRequestModel> mediaList;
  final BuildingModel? selectedBuilding;
  final ElevatorModel? selectedElevator;
  final List<ElevatorModel>? elevatorsList;
  final IssueType? issueType;
  final String? description;

  const CreateIssueState({
    this.status = CreateIssueStatus.initial,
    this.error,
    this.mediaList = const [],
    this.selectedBuilding,
    this.selectedElevator,
    this.elevatorsList,
    this.issueType,
    this.description,
  });

  IssueRequestModel toRequestModel() {
    return IssueRequestModel(
      mediaUrls: mediaList.map((m) => m.url).toList(),
      mediaList: mediaList,
      buildingName: selectedBuilding!.name,
      elevatorName: selectedElevator!.name,
      issueType: issueType!,
      priority: IssuePriority.values.firstWhere(
        (element) => element.name == issueType!.name,
        orElse: () => IssuePriority.low,
      ),
      description: description,
      buildingId: selectedBuilding!.id,
      elevatorId: selectedElevator!.id,
    );
  }

  CreateIssueState copyWith({
    CreateIssueStatus? status,
    String? error,
    List<MediaRequestModel>? mediaList,
    BuildingModel? selectedBuilding,
    ElevatorModel? selectedElevator,
    List<ElevatorModel>? elevatorsList,
    IssueType? issueType,
    String? description,
  }) {
    return CreateIssueState(
      status: status ?? this.status,
      error: error,
      mediaList: mediaList ?? this.mediaList,
      selectedBuilding: selectedBuilding ?? this.selectedBuilding,
      selectedElevator: selectedElevator ?? this.selectedElevator,
      elevatorsList: elevatorsList ?? this.elevatorsList,
      issueType: issueType ?? this.issueType,
      description: description ?? this.description,
    );
  }

  CreateIssueState reset() {
    return const CreateIssueState(
      status: CreateIssueStatus.initial,
      mediaList: [],
      selectedBuilding: null,
      selectedElevator: null,
      elevatorsList: null,
      issueType: null,
      description: null,
    );
  }
}
