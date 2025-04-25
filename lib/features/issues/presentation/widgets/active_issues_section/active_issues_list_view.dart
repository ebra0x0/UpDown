import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: Styles.borderRadius8),
          onTap: () => context.push(AppRouter.kissueView, extra: issue),
          title: Text(
            issue.issueType.title(context),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text("${issue.buildingName} , المصعد:${issue.elevatorName}",
              overflow: TextOverflow.ellipsis, maxLines: 1),
          leading: BubbleStatus(color: issue.status!.color),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
