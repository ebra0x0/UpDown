part of 'issue_details_cubit.dart';

class IssueDetailsState {
  final IssueResponseModel? issue;
  final ContentStatus status;
  final String? errorMsg;

  const IssueDetailsState(
      {this.issue, this.status = ContentStatus.initial, this.errorMsg});

  IssueDetailsState copyWith({
    IssueResponseModel? issue,
    ContentStatus? status,
    String? errorMsg,
  }) {
    return IssueDetailsState(
      issue: issue ?? this.issue,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
