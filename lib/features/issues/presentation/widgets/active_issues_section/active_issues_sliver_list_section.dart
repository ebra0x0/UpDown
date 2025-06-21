import 'dart:math';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ex_date_time.dart';
import 'package:UpDown/core/utils/extensions/ex_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ActiveIssuesSliverListSection extends StatelessWidget {
  const ActiveIssuesSliverListSection({
    super.key,
    required this.issues,
  });
  final List<IssueSummaryModel> issues;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: min(4, issues.length),
      itemBuilder: (context, index) {
        final issue = issues[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CardTile(
            leading: BubbleIcon(
              icon: Styles.errorOutlineIcon.copyWith(
                size: 22.sp,
              ),
              color: issue.status.color,
              padding: 8.sp,
            ),
            title: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              issue.issueType.title(context),
              style: Styles.textStyle16.copyWith(color: AppTheme.text),
            ),
            subtitle: Text("${issue.buildingName} - ${issue.elevatorName}",
                style: Styles.textStyle12.copyWith(
                  color: AppTheme.grey,
                )),
            footer: TextAndbubbleTextRow(
                text: issue.createdAt.toDateTimeFormat(),
                bubbleText: issue.status.title(context),
                bubbleColor: AppTheme.red),
            onTap: () => context.push(AppRouter.kissueView, extra: issue),
          ),
        );
      },
    );
  }
}
