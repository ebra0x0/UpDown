import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/date_and_bubble_text_row.dart';
import 'package:flutter/material.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveIssueTile extends StatelessWidget {
  const ActiveIssueTile({
    super.key,
    required this.issue,
    this.color,
    this.onTap,
  });

  final IssueModel issue;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 125,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: Styles.borderRadius18,
          boxShadow: [Styles.boxShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.sp,
          children: [
            BubbleIcon(
              icon: Styles.errorOutlineIcon.copyWith(
                size: 22.sp,
              ),
              color: color ?? AppTheme.red,
              padding: 8.sp,
            ),
            IssueTileContent(issue: issue),
            Spacer(),
            Styles.forwardIcon.copyWith(
              size: 18.sp,
              color: AppTheme.text,
            ),
          ],
        ),
      ),
    );
  }
}

class IssueTileContent extends StatelessWidget {
  const IssueTileContent({
    super.key,
    required this.issue,
  });

  final IssueModel issue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IssueTileTitle(issue: issue),
        DateAndbubbleTextRow(
            date: issue.createdAt ?? "",
            bubbleText: issue.status?.title(context) ?? "",
            bubbleColor: AppTheme.red),
      ],
    );
  }
}

class IssueTileTitle extends StatelessWidget {
  const IssueTileTitle({
    super.key,
    required this.issue,
  });

  final IssueModel issue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.sp,
      children: [
        Text(
          issue.issueType.title(context),
          style: Styles.textStyle16.copyWith(color: AppTheme.text),
        ),
        Text("${issue.buildingName} - ${issue.elevatorName}",
            style: Styles.textStyle12.copyWith(
              color: AppTheme.grey,
            )),
      ],
    );
  }
}
