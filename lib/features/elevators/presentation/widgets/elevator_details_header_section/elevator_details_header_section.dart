import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ext_box_border.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/date_and_bubble_text_row.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:flutter/material.dart';

class ElevatorDetailsAlertIssue extends StatelessWidget {
  const ElevatorDetailsAlertIssue({
    super.key,
    required this.state,
  });

  final ElevatorDetailsLoaded state;
  IssueModel? get activeIssue => state.elevator.activeIssue;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: activeIssue != null,
      child: Container(
        width: double.infinity,
        height: 125,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.red.withValues(alpha: 0.2),
          border: Styles.generalBoxBorder
              .copyWith(color: AppTheme.red.withValues(alpha: 0.2)),
          borderRadius: Styles.borderRadius18,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            BubbleIcon(
              icon: Styles.errorOutlineIcon.copyWith(
                size: 24,
              ),
              color: AppTheme.red,
              padding: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    activeIssue == null
                        ? ""
                        : "عطل ${activeIssue?.issueType.priority(context)}",
                    style: Styles.textStyle16.copyWith(
                      color: AppTheme.red,
                      fontWeight: FontWeight.w900,
                    )),
                Text(
                  activeIssue == null
                      ? ""
                      : activeIssue!.issueType.title(context),
                  style: Styles.textStyle14.copyWith(color: AppTheme.white),
                ),
                DateAndbubbleTextRow(
                    date: activeIssue?.createdAt ?? "",
                    bubbleText: activeIssue?.status?.title(context) ?? "",
                    bubbleColor: AppTheme.red),
              ],
            )
          ],
        ),
      ),
    );
  }
}
