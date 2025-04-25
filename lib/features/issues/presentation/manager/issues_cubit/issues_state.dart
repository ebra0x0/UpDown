part of 'issues_cubit.dart';

sealed class IssuesState {}

final class IssuesInitial extends IssuesState {}

final class IssuesLoading extends IssuesState {}

final class IssuesLoaded extends IssuesState {
  final List<IssueModel> activeIssues;

  IssuesLoaded({required this.activeIssues});
}

final class IssuesEmpty extends IssuesState {}

final class IssuesError extends IssuesState {
  final String error;
  IssuesError({required this.error});
}
