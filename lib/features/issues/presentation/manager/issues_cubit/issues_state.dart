part of 'issues_cubit.dart';

class IssuesState {
  final ContentStatus status;
  final String? errorMsg;
  final List<IssueResponseModel>? activeIssues;
  final List<IssueResponseModel>? issues;
  final IssueResponseModel? currentIssue;

  const IssuesState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.activeIssues,
    this.issues,
    this.currentIssue,
  });

  IssuesState copyWith({
    ContentStatus? status,
    String? errorMsg,
    List<IssueResponseModel>? activeIssues,
    List<IssueResponseModel>? issues,
    IssueResponseModel? currentIssue,
  }) {
    return IssuesState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      activeIssues: activeIssues ?? this.activeIssues,
      issues: issues ?? this.issues,
      currentIssue: currentIssue ?? this.currentIssue,
    );
  }
}
