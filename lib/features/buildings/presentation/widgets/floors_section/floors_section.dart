import 'dart:math';
import 'package:UpDown/features/buildings/data/models/floor_model.dart';
import 'package:UpDown/features/buildings/presentation/widgets/floors_section/floor_list_tile.dart';
import 'package:flutter/widgets.dart';

class BuildingFloorsSection extends StatelessWidget {
  const BuildingFloorsSection({super.key, required this.floors});

  final List<FloorModel> floors;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: min(floors.length, 4),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: FloorListTile(
          floor: floors[index],
        ),
      ),
    );
  }
}
