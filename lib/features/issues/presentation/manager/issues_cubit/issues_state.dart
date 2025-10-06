part of 'issues_cubit.dart';

class IssuesState {
  final ContentStatus status;
  final String? errorMsg;
  final List<IssueResponseModel>? issues;
  final IssueResponseModel? currentIssue;

  const IssuesState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.issues,
    this.currentIssue,
  });

  IssuesState copyWith({
    ContentStatus? status,
    String? errorMsg,
    List<IssueResponseModel>? issues,
    IssueResponseModel? currentIssue,
  }) {
    return IssuesState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      issues: issues ?? this.issues,
      currentIssue: currentIssue ?? this.currentIssue,
    );
  }
}
