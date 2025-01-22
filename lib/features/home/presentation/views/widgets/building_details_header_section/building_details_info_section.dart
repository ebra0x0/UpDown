import 'package:UpDown/core/utils/model/building_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

import 'building_attributes_box.dart';

class BuildingDetailsInfoSection extends StatelessWidget {
  const BuildingDetailsInfoSection({super.key, required this.building});

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        building.name,
        style: Styles.textStyle26,
      ),
      Container(
        height: 80,
        padding: const EdgeInsets.only(top: 16),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BuildingAttributesBox(
                icon: Icons.location_on_outlined,
                text: building.address,
              ),
              BuildingAttributesBox(
                icon: Icons.stairs_outlined,
                text: building.floorCount.toString(),
              ),
              BuildingAttributesBox(
                icon: Icons.elevator_outlined,
                text: building.elevators.length.toString(),
              ),
            ]),
      )
    ]);
  }
}
