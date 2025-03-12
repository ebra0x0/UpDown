import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/home/data/repos/home_repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'active_issues_state.dart';

class ActiveIssuesCubit extends Cubit<ActiveIssuesState> {
  ActiveIssuesCubit(this._repo) : super(ActiveIssuesInitial());

  final HomeRepo _repo;

  Future<void> fetchActiveIssues() async {
    emit(ActiveIssuesLoading());

    final result = await _repo.fetchActiveIssues();

    result.fold(
      (errMsg) => emit(ActiveIssuesError(error: errMsg.errMessage)),
      (issues) {
        emit(ActiveIssuesLoaded(activeIssues: issues));
      },
    );
  }
}
