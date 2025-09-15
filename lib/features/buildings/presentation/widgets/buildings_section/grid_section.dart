import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/building_card.dart';
import 'package:flutter/widgets.dart';

class BuildingsGridViewSection extends StatelessWidget {
  const BuildingsGridViewSection({
    super.key,
    required this.buildings,
  });

  final List<BuildingModel> buildings;

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8,
        childAspectRatio: 1 / 1.6,
      ),
      scrollDirection: Axis.horizontal,
      children: buildings
          .map((building) => BuildingCard(building: building))
          .toList(),
    );
  }
}
