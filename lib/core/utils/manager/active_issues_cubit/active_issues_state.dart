part of 'active_issues_cubit.dart';

enum ActiveIssuesStatus { initial, loading, empty, loaded, error }

class ActiveIssuesState {
  final ActiveIssuesStatus status;
  final String? errorMsg;
  final List<IssueSummaryModel>? issues;

  const ActiveIssuesState({
    this.status = ActiveIssuesStatus.initial,
    this.errorMsg,
    this.issues,
  });

  ActiveIssuesState copyWith({
    ActiveIssuesStatus? status,
    String? errorMsg,
    List<IssueSummaryModel>? issues,
  }) {
    return ActiveIssuesState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      issues: issues ?? this.issues,
    );
  }
}
