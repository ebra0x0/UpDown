part of 'issues_cubit.dart';

class IssuesState {
  final ContentStatus status;
  final String? errorMsg;
  final List<IssueResponseModel>? issues;

  const IssuesState({
    this.status = ContentStatus.initial,
    this.errorMsg,
    this.issues,
  });

  IssuesState copyWith({
    ContentStatus? status,
    String? errorMsg,
    List<IssueResponseModel>? issues,
  }) {
    return IssuesState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      issues: issues ?? this.issues,
    );
  }
}
