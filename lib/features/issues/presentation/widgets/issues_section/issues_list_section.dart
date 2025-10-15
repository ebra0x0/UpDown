import 'package:UpDown/core/theme/app_spacing.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/presentation/widgets/issues_section/issue_card.dart';
import 'package:flutter/widgets.dart';

class IssuesListSection extends StatelessWidget {
  const IssuesListSection({
    super.key,
    required this.issues,
  });
  final List<IssueResponseModel> issues;

  List<Widget> buildIssueWidgets() {
    return issues.take(3).map((e) => IssueCard(issue: e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(spacing: AppSpacing.s8, children: buildIssueWidgets());
  }
}
