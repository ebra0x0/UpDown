import 'package:UpDown/features/root/home/presentation/manager/building_details_cubit/cubit/building_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/building_elevators_box.dart';
import 'package:flutter/widgets.dart';

class BuildingDetailsElevatorsSection extends StatelessWidget {
  const BuildingDetailsElevatorsSection({super.key, required this.state});

  final BuildingDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1 / .75),
      itemCount: state.building!.elevators.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return BuildingElevatorsBox(
          elevator: state.building!.elevators[index],
        );
      },
    );
  }
}
