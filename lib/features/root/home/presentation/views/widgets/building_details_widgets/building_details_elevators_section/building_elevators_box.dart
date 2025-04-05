import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/widgets/custom_animated_button.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/elevator_box_content.dart';
import 'package:flutter/material.dart';

class BuildingElevatorsBox extends StatelessWidget {
  const BuildingElevatorsBox({super.key, required this.elevator});

  final ElevatorSummaryModel elevator;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
      child: ElevatorBoxContent(
        elevator: elevator,
      ),
      action: () {
        AppRouter.goToElevatorDetails(context, elevator.id);
      },
    );
  }
}
