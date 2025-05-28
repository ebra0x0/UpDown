import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/active_issues_section/active_issue_list_tile.dart';
import 'package:flutter/material.dart';

class ActiveIssuesListView extends StatelessWidget {
  const ActiveIssuesListView({
    super.key,
    required this.state,
  });
  final IssuesLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.activeIssues.length,
      itemBuilder: (context, index) {
        final issue = state.activeIssues[index];
        return ActiveIssueListTile(issue: issue);
      },
    );
  }
}
