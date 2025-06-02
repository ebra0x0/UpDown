import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/date_and_bubble_text_row.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:flutter/material.dart';

class ElevatorBoxContent extends StatelessWidget {
  const ElevatorBoxContent({
    super.key,
    required this.elevator,
  });

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: Styles.borderRadius18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatorBoxHeader(elevator: elevator),
          Text(
            elevator.status.description(context, elevator.issueType),
            style: Styles.textStyle14,
          ),
          ElevatorBoxFooter(elevator: elevator),
        ],
      ),
    );
  }
}

class ElevatorBoxFooter extends StatelessWidget {
  const ElevatorBoxFooter({
    super.key,
    required this.elevator,
  });

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    final IssueType? issueType = elevator.issueType;
    final String? issueDate = elevator.issueDate;
    return Visibility(
        visible: issueType != null && issueDate != null,
        child: DateAndbubbleTextRow(
          date: issueDate ?? "",
          bubbleText: elevator.issueType?.priority(context) ?? "",
          bubbleColor: AppTheme.red,
        ));
  }
}

class ElevatorBoxHeader extends StatelessWidget {
  const ElevatorBoxHeader({
    super.key,
    required this.elevator,
  });

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(spacing: 6, children: [
          BubbleStatus(color: elevator.status.color),
          Text(
            elevator.name,
            style: Styles.textStyle16,
          ),
        ]),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: elevator.status.color.withValues(alpha: 0.2),
          ),
          child: elevator.status.icon.copyWith(
            color: elevator.status.color,
          ),
        )
      ],
    );
  }
}
