import 'package:UpDown/core/utils/status_handler.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/root/home/data/model/attribute_model.dart';
import 'package:UpDown/features/root/home/presentation/manager/elevator_details_cubit/cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ElevatorDetailsHeaderSection extends StatelessWidget {
  const ElevatorDetailsHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorDetailsCubit, ElevatorDetailsState>(
        builder: (context, state) {
      final StatusHandler? status = state is ElevatorDetailsLoaded
          ? StatusHandler.fromElevatorStatus(
              status: state.elevator.status,
              issueType: state.elevator.activeIssue?.issueType,
              nextMaintenanceDate: state.elevator.nextMaintenanceDate,
            )
          : null;

      return SizedBox(
        height: 200,
        child: state is ElevatorDetailsLoaded
            ? Column(
                children: [
                  state.elevator.activeIssue != null
                      ? AlertBanner(
                          title: status!.description,
                          color: status.color,
                        )
                      : SizedBox(),
                  SizedBox(height: 12),
                  HeaderTitle(
                    elevatorNumber: state.elevator.elevatorNumber,
                    status: status!,
                  ),
                  SizedBox(height: 26),
                  AttributesSection(attributes: [
                    AttributeModel(
                        icon: Icons.assignment_late_outlined,
                        text: state.elevator.issues.length.toString()),
                    AttributeModel(
                        icon: Icons.timer_outlined,
                        text: state.elevator.nextMaintenanceDate != null
                            ? DateFormat.yMd()
                                .format(state.elevator.nextMaintenanceDate!)
                            : "لم يحدد بعد"),
                    AttributeModel(
                        text: state.elevator.lastMaintenanceDate != null
                            ? DateFormat.yMd()
                                .format(state.elevator.lastMaintenanceDate!)
                            : "لا توجد صيانات سابقة",
                        icon: Icons.calendar_month_outlined),
                    AttributeModel(
                        icon: Icons.groups_outlined,
                        text: state.elevator.maxLoad.toString()),
                  ])
                ],
              )
            : state is ElevatorDetailsError
                ? Center(child: Text(state.error))
                : DataLoadingIndicator(),
      );
    });
  }
}

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    super.key,
    required this.elevatorNumber,
    required this.status,
  });

  final int elevatorNumber;
  final StatusHandler status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "المصعد $elevatorNumber",
          style: Styles.textStyle26,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: Styles.borderRadius8,
            color: status.color.withValues(alpha: 0.1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            status.title,
            style: Styles.textStyle16.copyWith(color: status.color),
          ),
        ),
      ],
    );
  }
}
