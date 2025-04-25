import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/core/utils/model/attribute_model.dart';
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

  @override
  Widget build(BuildContext context) {
    ElevatorStatus status = state.elevator.status;
    IssueType? issueType = state.elevator.activeIssue?.issueType;

    return Column(
      children: [
        if (status != ElevatorStatus.working)
          AlertBannerIssue(
            title: status.description(context, issueType),
            color: status.color,
          ),
        const SizedBox(height: 26),
        AttributesSection(
          attributes: _buildAttributes(state),
        ),
      ],
    );
  }

  List<AttributeModel> _buildAttributes(ElevatorDetailsLoaded state) {
    return [
      AttributeModel(
        icon: Icons.assignment_late_outlined,
        text: state.elevator.issues.length.toString(),
      ),
      AttributeModel(
        icon: Icons.timer_outlined,
        text: state.elevator.nextMaintenanceDate != null
            ? DateFormat.yMd().format(state.elevator.nextMaintenanceDate!)
            : "لم يحدد بعد",
      ),
      AttributeModel(
        text: state.elevator.lastMaintenanceDate != null
            ? DateFormat.yMd().format(state.elevator.lastMaintenanceDate!)
            : "لا توجد صيانات سابقة",
        icon: Icons.calendar_month_outlined,
      ),
      AttributeModel(
        icon: Icons.groups_outlined,
        text: state.elevator.maxLoad.toString(),
      ),
    ];
  }
}
