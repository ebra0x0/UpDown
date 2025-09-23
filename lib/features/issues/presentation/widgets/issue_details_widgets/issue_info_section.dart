import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/section_box.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueInfoSection extends StatelessWidget {
  const IssueInfoSection({
    super.key,
    required this.issueId,
    required this.issueDate,
    required this.issueType,
    required this.issueStatus,
  });

  final String issueId;
  final String issueDate;
  final IssueType issueType;
  final IssueStatus issueStatus;
  String? get time => issueDate.split(',')[0];
  String? get date => issueDate.split(',')[1];

  @override
  Widget build(BuildContext context) {
    return SectionBox(
      children: [
        Row(
          spacing: 8.sp,
          children: [
            BubbleIcon(
              icon: issueType.icon,
              color: AppTheme.red,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.sp,
                  children: [
                    Text(
                      issueType.title(context),
                      style: AppTextStyles.textStyle18
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextAndbubbleTextRow(
                        text: "ID: #${issueId.substring(0, 7)}",
                        bubbleText: issueStatus.title(context),
                        bubbleColor: issueStatus.color),
                  ]),
            ),
          ],
        ),
        SizedBox(height: 14.sp),
        Row(
          spacing: 8.sp,
          children: [
            Expanded(
              child: _DateTile(
                icon: AppIcons.calendarIcon,
                label: 'تاريخ الإبلاغ',
                value: time ?? '',
              ),
            ),
            Expanded(
              child: _DateTile(
                icon: AppIcons.timeIcon,
                label: 'وقت النشر',
                value: date ?? '',
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _DateTile extends StatelessWidget {
  final Icon icon;
  final String label;
  final String value;

  const _DateTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SectionBox(
      crossAxisAlignment: CrossAxisAlignment.center,
      color: AppTheme.surface,
      spacing: 4.sp,
      children: [
        Row(
          spacing: 4.sp,
          children: [
            icon,
            Text(
              label,
              style: AppTextStyles.textStyle12,
            ),
          ],
        ),
        Text(
          value,
          style: AppTextStyles.textStyle14,
        )
      ],
    );
  }
}
