import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ext_box_border.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:flutter/material.dart';

class ElevatorDetailsActiveIssue extends StatelessWidget {
  const ElevatorDetailsActiveIssue({
    super.key,
    required this.state,
  });

  final ElevatorDetailsLoaded state;
  IssueModel? get activeIssue => state.elevator.activeIssue;

  @override
  Widget build(BuildContext context) {
    return CardTile(
      decoration: BoxDecoration(
        color: AppTheme.red.withValues(alpha: 0.2),
        border: Styles.generalBoxBorder
            .copyWith(color: AppTheme.red.withValues(alpha: 0.2)),
        borderRadius: Styles.borderRadius18,
      ),
      leading: BubbleIcon(
        icon: Styles.errorOutlineIcon.copyWith(
          size: 22,
        ),
        color: AppTheme.red,
        padding: 8,
      ),
      title: Text(
          activeIssue == null
              ? ""
              : "عطل ${activeIssue?.issueType.priority(context)}",
          style: Styles.textStyle16.copyWith(
            color: AppTheme.red,
            fontWeight: FontWeight.w900,
          )),
      body: Text(
        activeIssue == null ? "" : activeIssue!.issueType.title(context),
        style: Styles.textStyle14.copyWith(color: AppTheme.text),
      ),
      footer: TextAndbubbleTextRow(
          text: activeIssue?.createdAt ?? "",
          bubbleText: activeIssue?.status?.title(context) ?? "",
          bubbleColor: AppTheme.red),
    );
  }
}
