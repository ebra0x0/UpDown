import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ex_date_time.dart';
import 'package:UpDown/core/utils/extensions/ex_icon.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_response_model.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class ElevatorCard extends StatelessWidget {
  const ElevatorCard({super.key, required this.elevator});

  final ElevatorSummaryResponseModel elevator;

  @override
  Widget build(BuildContext context) {
    return CardTile(
      onTap: () {
        context.push(
            "${AppRoute.home.path}${AppRoute.elevator.path}/${elevator.id}");
      },
      title: _ElevatorCardHeader(name: elevator.name, status: elevator.status),
      body: Text(
        elevator.status.description(context, elevator.activeIssue?.issueType),
        style: AppTextStyles.textStyle14,
      ),
      footer: _ElevatorCardFooter(
          issueType: elevator.activeIssue?.issueType,
          issueDate: elevator.activeIssue?.issueDate),
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
    required this.name,
    required this.status,
  });

  final ElevatorStatus status;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 6, children: [
      BubbleStatus(color: status.color),
      Text(
        name,
        style: AppTextStyles.textStyle16,
      ),
    ]);
  }
}

class _ElevatorCardFooter extends StatelessWidget {
  const _ElevatorCardFooter({
    required this.issueType,
    required this.issueDate,
  });
  final IssueType? issueType;
  final DateTime? issueDate;

  @override
  Widget build(BuildContext context) {
    final bool hasActiveIssue = issueType != null;
    return Visibility(
        visible: hasActiveIssue,
        child: TextAndbubbleTextRow(
          text: issueDate?.toDateTimeFormat() ?? "",
          bubbleText: issueType?.priority(context) ?? "",
          bubbleColor: AppTheme.red,
        ));
  }
}
