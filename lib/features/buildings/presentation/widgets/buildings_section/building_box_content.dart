import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/building_box_footer.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/building_box_header.dart';
import 'package:flutter/material.dart';

class BuildingBoxContent extends StatelessWidget {
  const BuildingBoxContent({
    super.key,
    required this.building,
  });

  final BuildingSummaryModel building;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        BuildingBoxHeader(
            hasActiveReport: building.hasActiveReport,
            buildingName: building.name,
            elevatorsCount: building.elevatorsCount),
        BuildingBoxFooter(
          hasActiveReport: building.hasActiveReport,
        )
      ]),
    );
  }
}
