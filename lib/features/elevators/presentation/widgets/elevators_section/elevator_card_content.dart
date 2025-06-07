import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ElevatorCardContent extends StatelessWidget {
  const ElevatorCardContent({
    super.key,
    required this.elevator,
  });

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    return CardTile(
      onTap: () => context.push(AppRouter.kelevatorDetails, extra: elevator.id),
      title: _ElevatorCardHeader(elevator: elevator),
      body: Text(
        elevator.status.description(context, elevator.issueType),
        style: Styles.textStyle14,
      ),
      footer: _ElevatorCardFooter(elevator: elevator),
      trailing: BubbleIcon(
        icon: elevator.status.icon.copyWith(
          color: elevator.status.color,
        ),
        color: elevator.status.color,
      ),
    );
  }
}

class _ElevatorCardHeader extends StatelessWidget {
  const _ElevatorCardHeader({
    required this.elevator,
  });

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 6, children: [
      BubbleStatus(color: elevator.status.color),
      Text(
        elevator.name,
        style: Styles.textStyle16,
      ),
    ]);
  }
}

class _ElevatorCardFooter extends StatelessWidget {
  const _ElevatorCardFooter({
    required this.elevator,
  });

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    final IssueType? issueType = elevator.issueType;
    final String? issueDate = elevator.issueDate;
    return Visibility(
        visible: issueType != null && issueDate != null,
        child: TextAndbubbleTextRow(
          text: issueDate ?? "",
          bubbleText: elevator.issueType?.priority(context) ?? "",
          bubbleColor: AppTheme.red,
        ));
  }
}
