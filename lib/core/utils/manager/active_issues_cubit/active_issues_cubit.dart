import 'package:UpDown/features/issues/data/models/issue_summary_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'active_issues_state.dart';

class ActiveIssuesCubit extends Cubit<ActiveIssuesState> {
  ActiveIssuesCubit(this._repo) : super(ActiveIssuesState());

  final IssuesRepo _repo;
  final Set<IssueSummaryModel> _issues = {};

  Future<void> fetchAllActive() async {
    if (state.status == ActiveIssuesStatus.loading) return;

    emit(state.copyWith(status: ActiveIssuesStatus.loading));

    // get the exist issues if already loaded
    if (_issues.isNotEmpty) {
      emit(state.copyWith(
          status: ActiveIssuesStatus.loaded, issues: _issues.toList()));
      return;
    }

    // fetch new issues
    final result = await _repo.fetchAllActiveIssues();

    result.fold(
      (errMsg) => emit(state.copyWith(
          status: ActiveIssuesStatus.error, errorMsg: errMsg.errMessage)),
      (issues) {
        if (issues == null) {
          emit(state.copyWith(status: ActiveIssuesStatus.empty));
          return;
        }
        _issues.addAll(issues);
        emit(state.copyWith(
          status: ActiveIssuesStatus.loaded,
          issues: _issues.toList(),
        ));
      },
    );
  }

  Future<void> fetchAllActiveForBuilding(String buildingId) async {
    if (state.status == ActiveIssuesStatus.loading) return;

    emit(state.copyWith(status: ActiveIssuesStatus.loading));

    // get the exist issues if already loaded
    if (_issues.isNotEmpty) {
      final List<IssueSummaryModel> existingIssues =
          _issues.where((issue) => issue.buildingId == buildingId).toList();

      if (existingIssues.isNotEmpty) {
        emit(state.copyWith(
            status: ActiveIssuesStatus.loaded, issues: existingIssues));
        return;
      }
    }

    // fetch new issues
    final result = await _repo.fetchActiveIssuesForBuilding(buildingId);

    result.fold(
      (errMsg) => emit(state.copyWith(
          status: ActiveIssuesStatus.error, errorMsg: errMsg.errMessage)),
      (issues) {
        if (issues == null) {
          emit(state.copyWith(status: ActiveIssuesStatus.empty));
          return;
        }
        _issues.addAll(issues);
        emit(state.copyWith(
          status: ActiveIssuesStatus.loaded,
          issues: _issues.toList(),
        ));
      },
    );
  }

  Future<void> fetchAllActiveForElevator(String elevatorId) async {
    if (state.status == ActiveIssuesStatus.loading) return;

    emit(state.copyWith(status: ActiveIssuesStatus.loading));

    // get the exist issues if already loaded
    if (_issues.isNotEmpty) {
      final List<IssueSummaryModel> existingIssues =
          _issues.where((issue) => issue.elevatorId == elevatorId).toList();

      if (existingIssues.isNotEmpty) {
        emit(state.copyWith(
          status: ActiveIssuesStatus.loaded,
          issues: existingIssues,
        ));
        return;
      }
    }

    // fetch new issues
    final result = await _repo.fetchActiveIssuesForElevator(elevatorId);

    result.fold(
      (errMsg) => emit(state.copyWith(
          status: ActiveIssuesStatus.error, errorMsg: errMsg.errMessage)),
      (issues) {
        if (issues == null) {
          emit(state.copyWith(status: ActiveIssuesStatus.empty));
          return;
        }
        _issues.addAll(issues);
        emit(state.copyWith(
          status: ActiveIssuesStatus.loaded,
          issues: _issues.toList(),
        ));
      },
    );
  }
}
