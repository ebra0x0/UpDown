import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'issue_details_state.dart';

class IssueDetailsCubit extends Cubit<IssueDetailsState> {
  IssueDetailsCubit() : super(const IssueDetailsState());

  void setIssue(IssueResponseModel issue) {
    emit(state.copyWith(status: ContentStatus.loaded, issue: issue));
  }
}
