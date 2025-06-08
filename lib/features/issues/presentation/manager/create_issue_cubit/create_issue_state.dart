part of 'create_issue_cubit.dart';

enum CreateIssueStatus {
  initial,
  loading,
  error,
  success,
  selectLoading,
  selectSuccess,
}

class CreateIssueState {
  final CreateIssueStatus status;
  final String? error;
  final MediaModel? media;
  final BuildingSummaryModel? building;
  final ElevatorSummaryModel? elevator;
  final List<ElevatorSummaryModel>? elevators;
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

  CreateIssueState copyWith({
    CreateIssueStatus? status,
    String? error,
    MediaModel? media,
    BuildingSummaryModel? building,
    ElevatorSummaryModel? elevator,
    List<ElevatorSummaryModel>? elevators,
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
