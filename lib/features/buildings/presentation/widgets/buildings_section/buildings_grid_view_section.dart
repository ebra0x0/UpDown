import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/building_box.dart';
import 'package:flutter/widgets.dart';
import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';

class BuildingsGridViewSection extends StatelessWidget {
  const BuildingsGridViewSection({super.key, required this.state});

  final BuildingsLoaded state;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            childAspectRatio: 1 / .75),
        itemCount: state.buildings.length,
        itemBuilder: (context, index) {
          return BuildingBox(building: state.buildings[index]);
        });
  }
}
