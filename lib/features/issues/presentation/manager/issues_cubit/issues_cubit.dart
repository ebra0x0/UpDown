import 'dart:async';
import 'dart:developer';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/sort_list.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issues_state.dart';

class IssuesCubit extends Cubit<IssuesState> {
  IssuesCubit(this._repo) : super(const IssuesState());

  final IssuesRepo _repo;
  StreamSubscription? _streamAllSubscription;

  void emitStreamAllActiveIssues() {
    if (state.status == ContentStatus.loading ||
        _streamAllSubscription != null) {
      return;
    }

    emit(
      state.copyWith(
        status: ContentStatus.loading,
        activeIssues: List.generate(
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
            emit(state.copyWith(status: ContentStatus.empty, activeIssues: []));
            return;
          }

          _sortAndEmitActiveIssues(issues);

          if (state.currentIssue != null) {
            selectIssue(state.currentIssue!.id);
          }
        },
      );
    }, onError: (e) {
      if (isClosed) return;
      if (state.activeIssues != null) return;
      emit(state.copyWith(
        status: ContentStatus.error,
        errorMsg: e.toString(),
      ));
    });
  }

  Future<void> emitAllIssues() async {
    if (state.status == ContentStatus.loading) return;

    final int currentLength = state.issues?.length ?? 0;

    if (currentLength == 0) {
      emit(
        state.copyWith(
          status: ContentStatus.loading,
          issues: List.generate(
            2,
            (_) => IssueResponseModel.empty(),
          ),
        ),
      );
    }

    final result = await _repo.getIssues(offset: currentLength, limit: 5);
    if (isClosed) return;

    result.fold(
        (failure) => emit(state.copyWith(
            status: ContentStatus.error, errorMsg: failure.errMessage)),
        (issues) => _sortAndEmit(issues));
  }

  Future<void> emitBuildingIssues(String buildingId) async {
    if (state.status == ContentStatus.loading) return;

    emit(
      state.copyWith(
        status: ContentStatus.loading,
        issues: List.generate(
          2,
          (_) => IssueResponseModel.empty(),
        ),
      ),
    );

    final result = await _repo.getBuildingIssues(
        buildingId: buildingId, offset: state.issues?.length ?? 0, limit: 5);
    if (isClosed) return;

    result.fold(
        (failure) => emit(state.copyWith(
            status: ContentStatus.error,
            errorMsg: failure.errMessage)), (issues) {
      _sortAndEmit(issues);
    });
  }

  Future<void> emitElevatorIssues(String elevatorId) async {
    if (state.status == ContentStatus.loading) return;

    emit(
      state.copyWith(
        status: ContentStatus.loading,
        issues: List.generate(
          2,
          (_) => IssueResponseModel.empty(),
        ),
      ),
    );

    final result = await _repo.getElevatorIssues(
        elevatorId: elevatorId, offset: state.issues?.length ?? 0, limit: 5);
    if (isClosed) return;

    result.fold(
        (failure) => emit(state.copyWith(
            status: ContentStatus.error,
            errorMsg: failure.errMessage)), (issues) {
      _sortAndEmit(issues);
    });
  }

  void selectIssue(String issueId) {
    if (state.status == ContentStatus.loading || state.issues == null) return;

    final issueExists = state.issues!.any((issue) => issue.id == issueId);

    log("issueExists: $issueExists");

    if (!issueExists) return;

    emit(state.copyWith(
        currentIssue:
            state.issues!.firstWhere((issue) => issue.id == issueId)));
  }

  void _sortAndEmit(List<IssueResponseModel> issues) {
    final List<IssueResponseModel> sortedIssues =
        sortList(issues, (issue) => issue.createdAt);
    emit(state.copyWith(
      issues: sortedIssues,
      status: ContentStatus.loaded,
    ));
  }

  void _sortAndEmitActiveIssues(List<IssueResponseModel> issues) {
    final List<IssueResponseModel> sortedIssues =
        sortList(issues, (issue) => issue.createdAt);

    final Set<IssueResponseModel> activeIssuesAndIdle = {
      ...state.issues ?? [],
      ...sortedIssues
    };

    log(activeIssuesAndIdle.length.toString());
    emit(state.copyWith(
      status: ContentStatus.loaded,
      activeIssues: sortedIssues,
      issues: activeIssuesAndIdle.toList(),
    ));
  }

  @override
  Future<void> close() {
    _streamAllSubscription?.cancel();
    return super.close();
  }
}
