import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/date_time_ext.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class IssuesListSection extends StatelessWidget {
  const IssuesListSection({
    super.key,
    required this.issues,
  });
  final List<IssueSummaryResponseModel> issues;

  List<Widget> buildIssueWidgets() {
    return issues.map((e) => IssueCard(issue: e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: buildIssueWidgets());
  }
}

class IssueCard extends StatelessWidget {
  const IssueCard({
    super.key,
    required this.issue,
  });

  final IssueSummaryResponseModel issue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.bottom12,
      child: CardTile(
        leading: BubbleIcon(
          icon: AppIcons.errorOutlineIcon.copyWith(
            size: 22.sp,
          ),
          color: issue.status.color,
          padding: AppInsets.all8,
        ),
        title: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          issue.issueType.title(context),
          style: AppTextStyles.textStyle16.copyWith(color: AppTheme.text),
        ),
        subtitle: Text("${issue.buildingName} - ${issue.elevatorName}",
            style: AppTextStyles.textStyle12.copyWith(
              color: AppTheme.grey,
            )),
        footer: TextAndbubbleTextRow(
            text: issue.createdAt.toDateTimeFormat(),
            bubbleText: issue.status.title(context),
            bubbleColor: AppTheme.red),
        onTap: () {
          context
              .push("${AppRoute.home.path}${AppRoute.issue.path}/${issue.id}");
        },
      ),
    );
  }
}
