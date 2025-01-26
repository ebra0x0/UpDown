import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ElevatorBoxContent extends StatelessWidget {
  const ElevatorBoxContent(
      {super.key,
      required this.elevatorNumber,
      required this.elevatorStatus,
      required this.nextMaintenanceDate});

  final int elevatorNumber;
  final String elevatorStatus;
  final DateTime? nextMaintenanceDate;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          ElevatorBoxHeader(
            elevatorNumber: elevatorNumber,
            elevatorStatus: elevatorStatus,
          ),
          ElevatorBoxBody(
            elevatorStatus: elevatorStatus,
            nextMaintenanceDate: nextMaintenanceDate,
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

  Color getStatusColor(String status) {
    switch (status) {
      case "Working":
        return Pallete.success;
      case "Broken":
        return Pallete.error;
      case "Maintenance":
        return Pallete.warning;
      case "Repair":
        return Pallete.info;
      case "Disabled":
        return Pallete.secondary;
      default:
        return Pallete.secondary;
    }
  }

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
            color: getStatusColor(elevatorStatus).withValues(alpha: 0.2),
          ),
          child: Icon(
            Icons.circle,
            color: getStatusColor(elevatorStatus),
            size: 12,
          ),
        ),
      ],
    );
  }
}

class ElevatorBoxBody extends StatelessWidget {
  const ElevatorBoxBody(
      {super.key,
      required this.nextMaintenanceDate,
      required this.elevatorStatus});

  final DateTime? nextMaintenanceDate;
  final String elevatorStatus;

  String getStatusDescription(String status) {
    final String maintanceDate = nextMaintenanceDate == null
        ? "لم يحدد بعد"
        : DateFormat.yMd().format(nextMaintenanceDate!);

    switch (status) {
      case "Working":
        return 'الصيانة القادمة: $maintanceDate';
      case "Broken":
        return 'في إنتظار الفني';
      case "Maintenance":
        return 'تحت الصيانة';
      case "Repair":
        return 'وصل الفني وجاري الإصلاح';
      case "Disabled":
        return 'مغلق';
      default:
        return 'الصيانة القادمة: $maintanceDate';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(getStatusDescription(elevatorStatus),
            textAlign: TextAlign.center,
            style: Styles.textStyle14.copyWith(color: Pallete.textPrimary)),
      ),
    );
  }
}
