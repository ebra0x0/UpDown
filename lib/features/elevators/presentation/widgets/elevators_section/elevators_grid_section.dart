import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevator_card.dart';
import 'package:flutter/widgets.dart';

class ElevatorsGridSection extends StatelessWidget {
  const ElevatorsGridSection({super.key, required this.state});

  final ElevatorsLoaded state;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1 / .4,
      ),
      itemCount: state.elevators.length,
      itemBuilder: (context, index) {
        return ElevatorCard(
          elevator: state.elevators[index],
        );
      },
    );
  }
}
