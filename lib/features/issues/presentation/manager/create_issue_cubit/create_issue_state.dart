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
  final MediaRequestModel? media;
  final BuildingSummaryModel? building;
  final ElevatorSummaryResponseModel? elevator;
  final List<ElevatorSummaryResponseModel>? elevators;
  final IssueType? issueType;
  final String? description;

  const CreateIssueState({
    this.status = CreateIssueStatus.initial,
    this.error,
    this.media,
    this.building,
    this.elevator,
    this.elevators,
    this.issueType,
    this.description,
  });

  IssueRequestModel toRequestModel(BuildContext context) {
    return IssueRequestModel(
      media: media,
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
    MediaRequestModel? media,
    BuildingSummaryModel? building,
    ElevatorSummaryResponseModel? elevator,
    List<ElevatorSummaryResponseModel>? elevators,
    IssueType? issueType,
    String? description,
  }) {
    return CreateIssueState(
      status: status ?? this.status,
      error: error,
      media: media ?? this.media,
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
