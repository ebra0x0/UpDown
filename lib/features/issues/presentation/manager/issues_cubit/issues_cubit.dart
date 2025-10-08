import 'dart:async';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/sort_list.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issues_state.dart';

class IssuesCubit extends Cubit<IssuesState> {
  IssuesCubit(this._repo) : super(const IssuesState());

  final IssuesRepo _repo;
  StreamSubscription? _streamAllSubscription;
  StreamSubscription? _streamBuildingSubscription;
  StreamSubscription? _streamElevatorSubscription;

  void emitStreamAllActive() {
    if (state.status == ContentStatus.loading ||
        _streamAllSubscription != null) {
      return;
    }

    emit(
      state.copyWith(
        status: ContentStatus.loading,
        issues: List.generate(
          2,
          (_) => IssueResponseModel.empty(),
        ),
      ),
    );

    _streamAllSubscription = _repo.streamAllActiveIssues().listen((stream) {
      if (isClosed) return;
      stream.fold(
        (errMsg) => emit(state.copyWith(
          status: ContentStatus.error,
          errorMsg: errMsg.errMessage,
        )),
        (issues) {
          if (issues.isEmpty) {
            emit(state.copyWith(status: ContentStatus.empty, issues: []));
            return;
          }

          final List<IssueResponseModel> orderedIssues =
              sortList(issues, (issue) => issue.updatedAt ?? issue.createdAt);
          emit(state.copyWith(
            status: ContentStatus.loaded,
            issues: orderedIssues,
          ));
          if (state.currentIssue != null) {
            selectIssue(state.currentIssue!.id);
          }
        },
      );
    }, onError: (e) {
      if (isClosed) return;
      if (state.issues != null) return;
      emit(state.copyWith(
        status: ContentStatus.error,
        errorMsg: e.toString(),
      ));
    });
  }

  void selectIssue(String issueId) {
    if (state.status == ContentStatus.loading || state.issues == null) return;
    emit(state.copyWith(
        currentIssue:
            state.issues!.firstWhereOrNull((issue) => issue.id == issueId)));
  }

  @override
  Future<void> close() {
    _streamAllSubscription?.cancel();
    _streamBuildingSubscription?.cancel();
    _streamElevatorSubscription?.cancel();
    return super.close();
  }
}
