part of 'active_issues_cubit.dart';

sealed class ActiveIssuesState {}

final class ActiveIssuesInitial extends ActiveIssuesState {}

final class ActiveIssuesLoading extends ActiveIssuesState {}

final class ActiveIssuesLoaded extends ActiveIssuesState {
  final List<IssueModel> activeIssues;
  ActiveIssuesLoaded({required this.activeIssues});
}

final class ActiveIssuesError extends ActiveIssuesState {
  final String error;
  ActiveIssuesError({required this.error});
}
