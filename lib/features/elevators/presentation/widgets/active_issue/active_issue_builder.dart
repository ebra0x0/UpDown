import 'package:UpDown/core/theme/app_borders.dart';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ex_box_border.dart';
import 'package:UpDown/core/utils/extensions/ex_date_time.dart';
import 'package:UpDown/core/utils/extensions/ex_icon.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverActiveIssueBuilder extends StatelessWidget {
  const SliverActiveIssueBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: AppInsets.h8,
        sliver: BlocBuilder<IssuesCubit, IssuesState>(
          builder: (context, state) {
            if (state.status == ContentStatus.error) {
              return SliverToBoxAdapter(
                child: ScreenEcho(message: state.errorMsg!),
              );
            } else if (state.status == ContentStatus.empty) {
              return SliverToBoxAdapter(child: null);
            }

            return Skeletonizer.sliver(
              enabled: state.status == ContentStatus.loading,
              child: SliverToBoxAdapter(
                child: state.issues?.firstOrNull != null
                    ? ActiveIssueCardTile(activeIssue: state.issues!.first)
                    : null,
              ),
            );
          },
        ));
  }
}

class ActiveIssueCardTile extends StatelessWidget {
  final IssueSummaryResponseModel activeIssue;

  const ActiveIssueCardTile({
    super.key,
    required this.activeIssue,
  });

  @override
  Widget build(BuildContext context) {
    return CardTile(
      decoration: BoxDecoration(
        color: AppTheme.red.withValues(alpha: 0.2),
        border: AppBorders.generalBoxBorder
            .copyWith(color: AppTheme.red.withValues(alpha: 0.2)),
        borderRadius: AppRadius.borderRadius18,
      ),
      leading: BubbleIcon(
        icon: AppIcons.errorOutlineIcon.copyWith(
          size: 22,
        ),
        color: AppTheme.red,
        padding: AppInsets.all8,
      ),
      title: Text("عطل ${activeIssue.issueType.priority(context)}",
          style: AppTextStyles.textStyle16.copyWith(
            color: AppTheme.red,
            fontWeight: FontWeight.w900,
          )),
      body: Text(
        activeIssue.issueType.title(context),
        style: AppTextStyles.textStyle14.copyWith(color: AppTheme.text),
      ),
      footer: TextAndbubbleTextRow(
          text: activeIssue.createdAt.toDateTimeFormat(),
          bubbleText: activeIssue.status.title(context),
          bubbleColor: AppTheme.red),
    );
  }
}
