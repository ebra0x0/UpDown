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
  final BuildingModel? building;
  final ElevatorModel? elevator;
  final List<ElevatorModel>? elevators;
  final IssueType? issueType;
  final String? description;

  const CreateIssueState({
    this.status = CreateIssueStatus.initial,
    this.error,
    this.mediaList = const [],
    this.building,
    this.elevator,
    this.elevators,
    this.issueType,
    this.description,
  });

  IssueRequestModel toRequestModel() {
    return IssueRequestModel(
      mediaUrls: mediaList.map((m) => m.url).toList(),
      mediaList: mediaList,
      buildingName: building!.name,
      elevatorName: elevator!.name,
      issueType: issueType!,
      priority: IssuePriority.values.firstWhere(
        (element) => element.name == issueType!.name,
        orElse: () => IssuePriority.low,
      ),
      description: description,
      buildingId: building!.id,
      elevatorId: elevator!.id,
    );
  }

  CreateIssueState copyWith({
    CreateIssueStatus? status,
    String? error,
    List<MediaRequestModel>? mediaList,
    BuildingModel? building,
    ElevatorModel? elevator,
    List<ElevatorModel>? elevators,
    IssueType? issueType,
    String? description,
  }) {
    return CreateIssueState(
      status: status ?? this.status,
      error: error,
      mediaList: mediaList ?? this.mediaList,
      building: building ?? this.building,
      elevator: elevator ?? this.elevator,
      elevators: elevators ?? this.elevators,
      issueType: issueType ?? this.issueType,
      description: description ?? this.description,
    );
  }

  CreateIssueState reset() {
    return const CreateIssueState();
  }
}
