import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/issue_widgets/issue_info_section.dart';
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
