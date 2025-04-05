import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/features/root/home/presentation/manager/active_issues_cubit/cubit/active_issues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActiveIssuesListView extends StatelessWidget {
  const ActiveIssuesListView({
    super.key,
    required this.state,
  });
  final ActiveIssuesLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.activeIssues.length,
      itemBuilder: (context, index) {
        final issue = state.activeIssues[index];
        return ListTile(
          onTap: () =>
              context.push('${AppRouter.khomeView}/issueView', extra: issue),
          title: Text(
            issue.issueType.title(context),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text("${issue.buildingName} , المصعد:${issue.elevatorName}",
              overflow: TextOverflow.ellipsis, maxLines: 1),
          leading: BubbleStatus(color: issue.status.color),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
