import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/elevator_box_body.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/elevator_box_header.dart';
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
            name: elevator.name,
            status: elevator.status,
          ),
          ElevatorBoxBody(
            status: elevator.status,
          ),
        ],
      ),
    );
  }
}
