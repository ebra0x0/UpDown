import 'dart:async';

import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issue_details_state.dart';

class IssueDetailsCubit extends Cubit<IssueDetailsState> {
  final IssuesRepo _repo;
  late final StreamSubscription _subscription;
  IssueDetailsCubit(this._repo) : super(const IssueDetailsState());

  void call(String issueId) {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(
        status: ContentStatus.loading, issue: IssueResponseModel.empty()));

    _subscription = _repo.streamIssueDetails(issueId).listen((event) {
      if (isClosed) return;
      event.fold(
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
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
