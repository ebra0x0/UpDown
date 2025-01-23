import 'package:UpDown/core/widgets/custom_animated_button.dart';
import 'package:UpDown/features/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/elevator_box_content.dart';
import 'package:flutter/material.dart';

class BuildingElevatorsBox extends StatelessWidget {
  const BuildingElevatorsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
      child: ElevatorBoxContent(),
      action: () {},
    );
  }
}
