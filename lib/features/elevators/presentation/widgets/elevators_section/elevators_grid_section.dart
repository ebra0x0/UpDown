import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevator_box.dart';
import 'package:flutter/widgets.dart';

class ElevatorsGridSection extends StatelessWidget {
  const ElevatorsGridSection({super.key, required this.state});

  final ElevatorsLoaded state;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1 / .75),
      itemCount: state.elevators.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ElevatorsBox(
          elevator: state.elevators[index],
        );
      },
    );
  }
}
