import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issue_details_state.dart';

class IssueDetailsCubit extends Cubit<IssueDetailsState> {
  final IssuesRepo _repo;
  IssueDetailsCubit(this._repo) : super(const IssueDetailsState());

  void call(String issueId) {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(
        status: ContentStatus.loading, issue: IssueResponseModel.empty()));

    final result = _repo.fetchIssueDetails(issueId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ContentStatus.error,
          errorMsg: failure.errMessage,
        ));
      },
      (issue) {
        emit(state.copyWith(
          status: ContentStatus.loaded,
          issue: issue,
        ));
      },
    );
  }
}
