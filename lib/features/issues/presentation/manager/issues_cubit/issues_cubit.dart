import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issues_state.dart';

class IssuesCubit extends Cubit<IssuesState> {
  IssuesCubit(this._repo) : super(IssuesInitial());

  final IssuesRepo _repo;

  final List<IssueModel> activeIssues = [];

  Future<void> fetchActiveIssues() async {
    emit(IssuesLoading());

    final result = await _repo.fetchActiveIssues();

    result.fold(
      (errMsg) => emit(IssuesError(error: errMsg.errMessage)),
      (issues) {
        if (issues == null) {
          emit(IssuesEmpty());
          return;
        }
        activeIssues.addAll(issues);
        emit(IssuesLoaded(activeIssues: issues));
      },
    );
  }
}
