import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_units_section/elevator_details_units_card.dart';
import 'package:flutter/material.dart';

class ElevatorDetailsUnitSection extends StatelessWidget {
  const ElevatorDetailsUnitSection({super.key, required this.state});

  final ElevatorDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1 / .75),
        itemCount: state.elevator.units.length,
        itemBuilder: (context, index) => ElevatorUnitCard(
              unit: state.elevator.units[index],
            ));
  }
}
