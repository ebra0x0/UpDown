import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/features/root/home/data/model/attribute_model.dart';
import 'package:UpDown/features/root/home/presentation/manager/elevator_details_cubit/cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_view_body.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/elevator_details_widgets/elevator_details_header_section/elevator_details_header_title.dart';
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

    return Column(
      children: [
        if (state.elevator.activeIssue != null)
          AlertBanner(
            title: status.description(context),
            color: status.color,
          ),
        const SizedBox(height: 12),
        HeaderTitle(
          elevatorName: state.elevator.elevatorName,
          status: status,
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
