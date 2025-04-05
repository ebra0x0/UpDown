import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/elevator_details_widgets/elevator_details_header_section/elevator_details_header_status_title.dart';
import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    super.key,
    required this.elevatorName,
    required this.status,
  });

  final String elevatorName;
  final ElevatorStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          elevatorName,
          style: Styles.textStyle26,
        ),
        SizedBox(height: 12),
        StatusTitle(status: status),
      ],
    );
  }
}
