import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/active_issues_section/active_issues_sliver_list.dart';
import 'package:flutter/material.dart';

class ActiveIssuesSection extends StatelessWidget {
  const ActiveIssuesSection({super.key, required this.state});

  final IssuesLoaded state;

  @override
  Widget build(BuildContext context) {
    return ActiveIssuesSliverList(
      state: state,
    );
  }
}
