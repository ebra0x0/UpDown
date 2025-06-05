import 'dart:math';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/active_issues_section/active_issue_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActiveIssuesSliverList extends StatelessWidget {
  const ActiveIssuesSliverList({
    super.key,
    required this.state,
  });
  final IssuesLoaded state;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: min(4, state.activeIssues.length),
      itemBuilder: (context, index) {
        final issue = state.activeIssues[index];
        return ActiveIssueTile(
          issue: issue,
          onTap: () => context.push(AppRouter.kissueView, extra: issue),
        );
      },
    );
  }
}
