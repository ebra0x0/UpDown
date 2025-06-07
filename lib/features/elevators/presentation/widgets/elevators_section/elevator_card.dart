import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevator_card_content.dart';
import 'package:flutter/material.dart';

class ElevatorCard extends StatelessWidget {
  const ElevatorCard({super.key, required this.elevator});

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    return ElevatorCardContent(
      elevator: elevator,
    );
  }
}
