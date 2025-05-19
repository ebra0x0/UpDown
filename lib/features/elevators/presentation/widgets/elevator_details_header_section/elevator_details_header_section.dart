import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_header_section/alert_banner_issue.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ElevatorDetailsHeaderSection extends StatelessWidget {
  const ElevatorDetailsHeaderSection({
    super.key,
    required this.state,
  });

  final ElevatorDetailsLoaded state;

  ElevatorStatus get status => state.elevator.status;
  IssueType? get issueType => state.elevator.activeIssue?.issueType;
  List<Map<String, dynamic>> get attributes => [
        {
          'icon': Styles.reportIcon.icon,
          'text': state.elevator.issues.length.toString()
        },
        {
          'icon': Styles.maintenanceIcon.icon,
          'text': state.elevator.nextMaintenanceDate != null
              ? DateFormat.yMd().format(state.elevator.nextMaintenanceDate!)
              : "لم يحدد بعد"
        },
        {
          'text': state.elevator.lastMaintenanceDate != null
              ? DateFormat.yMd().format(state.elevator.lastMaintenanceDate!)
              : "لا توجد صيانات سابقة",
          'icon': Styles.calendarIcon.icon,
        },
        {
          'icon': Styles.groupIcon.icon,
          'text': state.elevator.maxLoad.toString()
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (status != ElevatorStatus.working)
          AlertBannerIssue(
            title: status.description(context, issueType),
            color: status.color,
          ),
        const SizedBox(height: 26),
        AttributesSection(attributes: attributes),
      ],
    );
  }
}
