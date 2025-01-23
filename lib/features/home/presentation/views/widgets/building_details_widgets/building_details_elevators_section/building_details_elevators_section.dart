import 'package:UpDown/features/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/building_elevators_box.dart';
import 'package:flutter/widgets.dart';

class BuildingDetailsElevatorsSection extends StatelessWidget {
  const BuildingDetailsElevatorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2 / 1.5),
      itemCount: 4,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return BuildingElevatorsBox();
      },
    );
  }
}
