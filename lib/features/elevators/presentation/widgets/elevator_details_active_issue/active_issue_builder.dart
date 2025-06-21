import 'package:UpDown/core/utils/manager/active_issues_cubit/active_issues_cubit.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_active_issue/active_issue_card_tile.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverActiveIssueBuilder extends StatelessWidget {
  final String elevatorId;

  const SliverActiveIssueBuilder({
    super.key,
    required this.elevatorId,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        sliver: BlocBuilder<ActiveIssuesCubit, ActiveIssuesState>(
          builder: (context, state) {
            if (state.status == ActiveIssuesStatus.error) {
              return SliverToBoxAdapter(
                child: ScreenEcho(message: state.errorMsg!),
              );
            } else if (state.status == ActiveIssuesStatus.empty) {
              return SliverToBoxAdapter(child: null);
            }

            final IssueSummaryModel? activeIssue = state.issues
                ?.where((issue) => issue.elevatorId == elevatorId)
                .firstOrNull;

            return Skeletonizer.sliver(
              enabled: state.status == ActiveIssuesStatus.loading,
              child: SliverToBoxAdapter(
                child: activeIssue != null
                    ? ActiveIssueCardTile(activeIssue: activeIssue)
                    : null,
              ),
            );
          },
        ));
  }
}
