import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
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
        IssueInfoRow(issue: issue, icon: Icons.apartment_rounded),
        SizedBox(height: 16),
        IssueInfoRow(issue: issue, icon: Icons.date_range),
        SizedBox(height: 16),
        IssueInfoRow(issue: issue, icon: Icons.info_outlined),
        SizedBox(height: 16),
        IssueInfoRow(issue: issue, icon: Icons.description_outlined),
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
        Icon(icon, color: Pallete.lightSecondary, size: 24),
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
