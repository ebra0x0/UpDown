import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ActiveIssueListTile extends StatelessWidget {
  const ActiveIssueListTile({
    super.key,
    required this.issue,
  });

  final IssueModel issue;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: issue.issueType.title(context),
      subtitle:
          "${issue.buildingName} ● ${issue.elevatorName} ( ${issue.status!.title(context)} )",
      leading: BubbleStatus(color: issue.status!.color),
      trailing: Styles.forwardIcon.copyWith(
        size: 18.sp,
      ),
      onTap: () => context.push(AppRouter.kissueView, extra: issue),
    );
  }
}
