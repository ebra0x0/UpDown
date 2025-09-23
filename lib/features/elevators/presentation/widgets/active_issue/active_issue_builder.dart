import 'package:UpDown/core/theme/app_borders.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/box_border_ext.dart';
import 'package:UpDown/core/utils/extensions/date_time_ext.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';

class SliverActiveIssueBuilder extends StatelessWidget {
  const SliverActiveIssueBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: AppInsets.h8,
        sliver: BlocBuilder<IssuesCubit, IssuesState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return AppSkeletonizer(
              isSliver: true,
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
  final IssueResponseModel activeIssue;

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
        icon: activeIssue.issueType.icon,
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
