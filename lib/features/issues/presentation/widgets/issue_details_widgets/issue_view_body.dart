import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_info_section.dart';
import 'package:flutter/material.dart';

class IssueViewBody extends StatelessWidget {
  const IssueViewBody({
    super.key,
    required this.issue,
  });

  final IssueModel issue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: IssueInfoSection(issue: issue),
      ),
    );
  }
}
