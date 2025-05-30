import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/widgets/custom_animated_button.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevator_box_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ElevatorBox extends StatelessWidget {
  const ElevatorBox({super.key, required this.elevator});

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
      child: ElevatorBoxContent(
        elevator: elevator,
      ),
      action: () {
        context.push(AppRouter.kelevatorDetails, extra: elevator.id);
      },
    );
  }
}
