import 'package:UpDown/features/home/data/model/elevator_model.dart';
import 'package:UpDown/features/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/building_elevators_box.dart';
import 'package:flutter/widgets.dart';

class BuildingDetailsElevatorsSection extends StatelessWidget {
  const BuildingDetailsElevatorsSection({super.key, required this.elevators});

  final List<ElevatorModel> elevators;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2 / 1.5),
      itemCount: elevators.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return BuildingElevatorsBox(
          elevator: elevators[index],
        );
      },
    );
  }
}
