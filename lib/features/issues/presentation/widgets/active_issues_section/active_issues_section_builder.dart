import 'package:UpDown/core/utils/manager/active_issues_cubit/active_issues_cubit.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/issues/presentation/widgets/active_issues_section/active_issues_sliver_list_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ActiveIssuesSectionBuilder extends StatelessWidget {
  const ActiveIssuesSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveIssuesCubit, ActiveIssuesState>(
        builder: (context, state) {
      if (state.status == ActiveIssuesStatus.error) {
        return SliverToBoxAdapter(
          child: ScreenEcho(message: state.errorMsg!),
        );
      } else if (state.status == ActiveIssuesStatus.empty) {
        return SliverToBoxAdapter(child: null);
      }
      return Skeletonizer.sliver(
        enabled: state.status == ActiveIssuesStatus.loading,
        child: ActiveIssuesSliverListSection(
            issues:
                state.status == ActiveIssuesStatus.loaded ? state.issues! : []),
      );
    });
  }
}
