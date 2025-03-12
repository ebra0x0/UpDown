import 'package:UpDown/core/utils/function/get_status_color.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/status_handler.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:flutter/material.dart';

class ElevatorBoxContent extends StatelessWidget {
  const ElevatorBoxContent({
    super.key,
    required this.elevator,
  });

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          ElevatorBoxHeader(
            elevatorNumber: elevator.elevatorNumber,
            elevatorStatus: elevator.status,
          ),
          ElevatorBoxBody(
            nextMaintenanceDate: elevator.nextMaintenanceDate,
            elevatorStatus: elevator.status,
            issueType: elevator.issueType,
          ),
        ],
      ),
    );
  }
}

class ElevatorBoxHeader extends StatelessWidget {
  const ElevatorBoxHeader(
      {super.key, required this.elevatorNumber, required this.elevatorStatus});
  final int elevatorNumber;
  final String elevatorStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('مصعد ${elevatorNumber.toString()}',
            style: Styles.textStyle14.copyWith(color: Pallete.textSecondary)),
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: elevatorStatus != "Disabled"
                ? getStatusColor(elevatorStatus).withValues(alpha: 0.2)
                : Colors.transparent,
          ),
          child: elevatorStatus != "Disabled"
              ? Icon(
                  Icons.circle,
                  color: getStatusColor(elevatorStatus),
                  size: 12,
                )
              : Icon(Icons.lock,
                  color: getStatusColor(elevatorStatus), size: 16),
        ),
      ],
    );
  }
}

class ElevatorBoxBody extends StatelessWidget {
  const ElevatorBoxBody(
      {super.key,
      required this.issueType,
      required this.nextMaintenanceDate,
      required this.elevatorStatus});

  final DateTime? nextMaintenanceDate;
  final String? issueType;
  final String elevatorStatus;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
            StatusHandler.fromElevatorStatus(
                    status: elevatorStatus,
                    issueType: issueType,
                    nextMaintenanceDate: nextMaintenanceDate)
                .description!,
            textAlign: TextAlign.center,
            style: Styles.textStyle14.copyWith(
                fontWeight: FontWeight.bold, color: Pallete.textPrimary)),
      ),
    );
  }
}
