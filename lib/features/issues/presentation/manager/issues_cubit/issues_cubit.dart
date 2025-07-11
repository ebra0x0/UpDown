import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/helper/sort_list.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issues_state.dart';

class IssuesCubit extends Cubit<IssuesState> {
  IssuesCubit(this._repo) : super(IssuesState());

  final IssuesRepo _repo;
  final Set<IssueSummaryResponseModel> _issues = {};

  Future<void> fetchAllActive() async {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(status: ContentStatus.loading));

    // get the exist issues if already loaded
    if (_issues.isNotEmpty) {
      emit(state.copyWith(
          status: ContentStatus.loaded, issues: _issues.toList()));
      return;
    }

    // fetch new issues
    final result = await _repo.fetchAllActiveIssues();

    result.fold(
      (errMsg) => emit(state.copyWith(
          status: ContentStatus.error, errorMsg: errMsg.errMessage)),
      (issues) {
        if (issues == null) {
          emit(state.copyWith(status: ContentStatus.empty));
          return;
        }
        _issues.addAll(issues);
        emit(state.copyWith(
          status: ContentStatus.loaded,
          issues: _issues.toList(),
        ));
      },
    );
  }

  Future<void> fetchAllActiveForBuilding(String buildingId) async {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(status: ContentStatus.loading));

    // get the exist issues if already loaded
    if (_issues.isNotEmpty) {
      final List<IssueSummaryResponseModel> existingIssues =
          _issues.where((issue) => issue.buildingId == buildingId).toList();

      if (existingIssues.isNotEmpty) {
        // Sort the issues by date
        final List<IssueSummaryResponseModel> sortedIssues = sortList(
            existingIssues, (issue) => issue.updatedAt ?? issue.createdAt);

        emit(
            state.copyWith(status: ContentStatus.loaded, issues: sortedIssues));
        return;
      }
    }

    // fetch new issues
    final result = await _repo.fetchActiveIssuesForBuilding(buildingId);

    result.fold(
      (errMsg) => emit(state.copyWith(
          status: ContentStatus.error, errorMsg: errMsg.errMessage)),
      (issues) {
        if (issues == null) {
          emit(state.copyWith(status: ContentStatus.empty));
          return;
        }
        _issues.addAll(issues);
        final List<IssueSummaryResponseModel> orderedIssues =
            sortList(issues, (issue) => issue.updatedAt ?? issue.createdAt);

        emit(state.copyWith(
          status: ContentStatus.loaded,
          issues: orderedIssues,
        ));
      },
    );
  }

  Future<void> fetchAllActiveForElevator(String elevatorId) async {
    if (state.status == ContentStatus.loading) return;

    emit(state.copyWith(status: ContentStatus.loading));

    // get the exist issues if already loaded
    if (_issues.isNotEmpty) {
      final List<IssueSummaryResponseModel> existingIssues =
          _issues.where((issue) => issue.elevatorId == elevatorId).toList();

      if (existingIssues.isNotEmpty) {
        final List<IssueSummaryResponseModel> orderedIssues = sortList(
            existingIssues, (issue) => issue.updatedAt ?? issue.createdAt);
        emit(state.copyWith(
          status: ContentStatus.loaded,
          issues: orderedIssues,
        ));
        return;
      }
    }

    // fetch new issues
    final result = await _repo.fetchActiveIssuesForElevator(elevatorId);

    result.fold(
      (errMsg) => emit(state.copyWith(
          status: ContentStatus.error, errorMsg: errMsg.errMessage)),
      (issues) {
        if (issues == null) {
          emit(state.copyWith(status: ContentStatus.empty));
          return;
        }
        _issues.addAll(issues);
        final List<IssueSummaryResponseModel> orderedIssues =
            sortList(issues, (issue) => issue.updatedAt ?? issue.createdAt);
        emit(state.copyWith(
          status: ContentStatus.loaded,
          issues: orderedIssues,
        ));
      },
    );
  }
}
