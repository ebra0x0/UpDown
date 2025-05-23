import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:flutter/material.dart';

class IssueInfoSection extends StatelessWidget {
  const IssueInfoSection({
    super.key,
    required this.issue,
  });

  final IssueModel issue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IssueInfoRow(issue: issue, icon: Styles.apartmentIcon.icon!),
        SizedBox(height: 16),
        IssueInfoRow(issue: issue, icon: Styles.calendarIcon.icon!),
        SizedBox(height: 16),
        IssueInfoRow(issue: issue, icon: Styles.reportIcon.icon!),
        SizedBox(height: 16),
        IssueInfoRow(issue: issue, icon: Styles.descriptionIcon.icon!),
      ],
    );
  }
}

class IssueInfoRow extends StatelessWidget {
  const IssueInfoRow({
    super.key,
    required this.issue,
    required this.icon,
  });

  final IssueModel issue;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.grey, size: 24),
        SizedBox(width: 8),
        Text(
          issue.buildingName,
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
