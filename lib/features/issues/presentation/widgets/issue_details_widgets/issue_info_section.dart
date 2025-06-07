import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:flutter/material.dart';
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
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: Styles.borderRadius14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8.sp,
            children: [
              BubbleIcon(
                icon: Styles.errorOutlineIcon,
                color: AppTheme.red,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.sp,
                  children: [
                    Text(
                      issueType.title(context),
                      style: Styles.textStyle18
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextAndbubbleTextRow(
                        text: "ID: ${issueId.substring(0, 8)}",
                        bubbleText: issueStatus.title(context),
                        bubbleColor: issueStatus.color),
                  ]),
            ],
          ),
          SizedBox(height: 14.sp),
          Row(
            spacing: 8.sp,
            children: [
              Expanded(
                child: _DateTile(
                  icon: Styles.calendarIcon,
                  label: 'تاريخ الإبلاغ',
                  value: time ?? '',
                ),
              ),
              Expanded(
                child: _DateTile(
                  icon: Styles.timeIcon,
                  label: 'وقت النشر',
                  value: date ?? '',
                ),
              ),
            ],
          )
        ],
      ),
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
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: Styles.borderRadius12,
      ),
      child: Column(
        spacing: 4.sp,
        children: [
          Row(
            spacing: 4.sp,
            children: [
              icon,
              Text(
                label,
                style: Styles.textStyle12,
              ),
            ],
          ),
          Text(
            value,
            style: Styles.textStyle14,
          )
        ],
      ),
    );
  }
}
