import 'package:UpDown/core/widgets/data_loading_shimmer.dart';
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
        return SliverFillRemaining(child: ActiveIssuesSection(state: state));
      } else if (state is IssuesError) {
        return SliverToBoxAdapter(
          child: Center(
            child: Text(state.error),
          ),
        );
      } else if (state is IssuesEmpty) {
        return SliverToBoxAdapter(
            child: Visibility(visible: false, child: SizedBox()));
      }
      return SliverToBoxAdapter(child: DataLoadingIndicator());
    });
  }
}
