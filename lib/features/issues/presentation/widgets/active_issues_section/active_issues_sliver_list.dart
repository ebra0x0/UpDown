import 'dart:math';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/date_and_bubble_text_row.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        return CardTile(
          leading: BubbleIcon(
            icon: Styles.errorOutlineIcon.copyWith(
              size: 22.sp,
            ),
            color: issue.status?.color ?? AppTheme.red,
            padding: 8.sp,
          ),
          title: Text(
            issue.issueType.title(context),
            style: Styles.textStyle16.copyWith(color: AppTheme.text),
          ),
          subtitle: Text("${issue.buildingName} - ${issue.elevatorName}",
              style: Styles.textStyle12.copyWith(
                color: AppTheme.grey,
              )),
          footer: DateAndbubbleTextRow(
              date: issue.createdAt ?? "",
              bubbleText: issue.status?.title(context) ?? "",
              bubbleColor: AppTheme.red),
          onTap: () => context.push(AppRouter.kissueView, extra: issue),
        );
      },
    );
  }
}
