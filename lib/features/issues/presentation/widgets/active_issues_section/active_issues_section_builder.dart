import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/core/widgets/custom_error.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/active_issues_section/active_issues_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveIssuesSectionBuilder extends StatelessWidget {
  const ActiveIssuesSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(builder: (context, state) {
      if (state is IssuesLoaded) {
        return ActiveIssuesSection(state: state);
      } else if (state is IssuesError) {
        return CustomError(
          errorMessage: state.error,
        );
      } else if (state is IssuesEmpty) {
        return SizedBox();
      }
      return DataLoadingIndicator();
    });
  }
}
