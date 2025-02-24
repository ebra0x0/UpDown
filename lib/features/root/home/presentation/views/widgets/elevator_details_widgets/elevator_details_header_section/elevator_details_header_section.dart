import 'package:UpDown/core/utils/status_handler.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/root/home/data/model/attribute_model.dart';
import 'package:UpDown/features/root/home/presentation/manager/elevator_cubit/cubit/elevator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ElevatorDetailsHeaderSection extends StatelessWidget {
  const ElevatorDetailsHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorCubit, ElevatorState>(builder: (context, state) {
      return SizedBox(
        height: 170,
        child: state is ElevatorLoaded
            ? Column(
                children: [
                  HeaderTitle(
                    elevatorNumber: state.elevator.elevatorNumber,
                    status: state.elevator.status,
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
            : state is ElevatorError
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
  final String status;

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
            color: StatusHandler.getStatusColor(status).withValues(alpha: 0.1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            StatusHandler.getStatusTitle(status: status),
            style: Styles.textStyle16
                .copyWith(color: StatusHandler.getStatusColor(status)),
          ),
        ),
      ],
    );
  }
}
