import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevator_card.dart';
import 'package:flutter/widgets.dart';

class ElevatorsSliverGridSection extends StatelessWidget {
  const ElevatorsSliverGridSection({super.key, required this.elevators});

  final List<ElevatorSummaryModel> elevators;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1 / .37,
      ),
      itemCount: elevators.length,
      itemBuilder: (context, index) {
        return ElevatorCard(
          elevator: elevators[index],
        );
      },
    );
  }
}
