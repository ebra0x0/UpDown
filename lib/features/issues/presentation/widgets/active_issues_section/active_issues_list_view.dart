import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          contentPadding: EdgeInsets.only(left: 16),
          shape: RoundedRectangleBorder(borderRadius: Styles.borderRadius8),
          onTap: () => context.push(AppRouter.kissueView, extra: issue),
          title: Text(
            issue.issueType.title(context),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Styles.textStyle14,
          ),
          subtitle: Text(
            "${issue.buildingName} ● ${issue.elevatorName}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Styles.textStyle12.copyWith(
              color: AppTheme.grey,
            ),
          ),
          leading: BubbleStatus(color: issue.status!.color),
          trailing: Styles.forwardIcon.copyWith(
            color: AppTheme.grey,
            size: 18.sp,
          ),
        );
      },
    );
  }
}
