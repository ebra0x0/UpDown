import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:UpDown/features/issues/presentation/widgets/issues_section/issues_sliver_list_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class IssuesSectionBuilder extends StatelessWidget {
  const IssuesSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(builder: (context, state) {
      if (state.status == ContentStatus.error) {
        return SliverToBoxAdapter(
          child: ScreenEcho(message: state.errorMsg!),
        );
      } else if (state.status == ContentStatus.empty) {
        return SliverToBoxAdapter(child: null);
      }
      return Skeletonizer.sliver(
        containersColor: AppTheme.background,
        enabled: state.status == ContentStatus.loading,
        child: IssuesSliverListSection(
            issues: state.status == ContentStatus.loaded
                ? state.issues!
                : List.generate(2, (_) => IssueSummaryResponseModel.empty())),
      );
    });
  }
}
