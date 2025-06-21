import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/building_card.dart';
import 'package:flutter/widgets.dart';

class BuildingsSliverGridViewSection extends StatelessWidget {
  const BuildingsSliverGridViewSection({
    super.key,
    required this.buildings,
  });

  final List<BuildingSummaryModel> buildings;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            childAspectRatio: 1 / .75),
        itemCount: buildings.length,
        itemBuilder: (context, index) {
          return BuildingCard(building: buildings[index]);
        });
  }
}
