part of 'create_issue_cubit.dart';

sealed class CreateIssueState {}

final class CreateIssueInitial extends CreateIssueState {}

final class CreateIssueLoading extends CreateIssueState {}

final class CreateIssueError extends CreateIssueState {
  final String error;
  CreateIssueError({required this.error});
}

final class CreateIssueSuccess extends CreateIssueState {}

final class SelectSuccess extends CreateIssueState {
  final MediaModel? media;
  final BuildingSummaryModel? building;
  final ElevatorSummaryModel? elevator;
  final String? issueType;
  final String? description;

  SelectSuccess(
      {this.media,
      this.building,
      this.elevator,
      this.issueType,
      this.description});

  SelectSuccess copyWith({
    MediaModel? media,
    BuildingSummaryModel? building,
    ElevatorSummaryModel? elevator,
    String? issueType,
    String? description,
  }) {
    return SelectSuccess(
      media: media ?? this.media,
      building: building ?? this.building,
      elevator: elevator ?? this.elevator,
      issueType: issueType ?? this.issueType,
      description: description ?? this.description,
    );
  }
}

final class SelectLoading extends CreateIssueState {}
