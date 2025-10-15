import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/date_time_ext.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class IssueCard extends StatelessWidget {
  const IssueCard({
    super.key,
    required this.issue,
  });

  final IssueResponseModel issue;

  @override
  Widget build(BuildContext context) {
    return CardTile(
      leading: BubbleIcon(
        icon: issue.issueType.icon.copyWith(
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
        context.push("${AppRoute.home.path}${AppRoute.issue.path}/${issue.id}",
            extra: issue);
      },
    );
  }
}
