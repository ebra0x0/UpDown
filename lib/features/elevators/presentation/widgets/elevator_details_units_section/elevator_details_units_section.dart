import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_units_section/elevator_details_units_card.dart';
import 'package:flutter/widgets.dart';

class ElevatorDetailsUnitSection extends StatelessWidget {
  final List<UnitModel> units;

  const ElevatorDetailsUnitSection({super.key, required this.units});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1 / .75),
        itemCount: units.length,
        itemBuilder: (context, index) => ElevatorUnitCard(
              unit: units[index],
            ));
  }
}
