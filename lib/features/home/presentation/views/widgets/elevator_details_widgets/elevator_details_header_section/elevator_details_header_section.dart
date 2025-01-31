import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/status_handler.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/home/presentation/manager/elevator_cubit/cubit/elevator_cubit.dart';
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
                  HeaderAttributes(
                      nextMaintenanceDate: state.elevator.nextMaintenanceDate,
                      floors: state.elevator.floors.length,
                      maxLoad: state.elevator.maxLoad,
                      closedFloors: state.elevator.closedFloors.length),
                ],
              )
            : state is ElevatorError
                ? Center(child: Text(state.error))
                : LoadingIndicator(),
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
            borderRadius: BorderRadius.circular(8),
            color: Pallete.success.withValues(alpha: 0.1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            StatusHandler.getStatusTitle(status: status),
            style: Styles.textStyle16.copyWith(color: Pallete.success),
          ),
        ),
      ],
    );
  }
}

class HeaderAttributes extends StatelessWidget {
  const HeaderAttributes({
    super.key,
    required this.nextMaintenanceDate,
    required this.floors,
    required this.maxLoad,
    required this.closedFloors,
  });

  final DateTime? nextMaintenanceDate;
  final int floors;
  final int maxLoad;
  final int closedFloors;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(spacing: 4, children: [
        Icon(Icons.groups_outlined, color: Colors.grey),
        Text(maxLoad.toString()),
      ]),
      Column(spacing: 4, children: [
        Icon(Icons.handyman_outlined, color: Colors.grey),
        Text(nextMaintenanceDate == null
            ? "الصيانة القادمة لم تحدد"
            : DateFormat.yMd().format(nextMaintenanceDate!)),
      ]),
      Column(spacing: 4, children: [
        Icon(Icons.stairs_outlined, color: Colors.grey),
        Text(floors.toString()),
      ]),
      Column(spacing: 4, children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Icon(
              Icons.door_back_door_outlined,
              color: Colors.grey,
            ),
            Icon(
              Icons.lock_rounded,
              color: Colors.grey,
              size: 14,
            ),
          ],
        ),
        Text(closedFloors.toString()),
      ]),
    ]);
  }
}
