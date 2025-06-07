import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/building_card_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildingBox extends StatelessWidget {
  const BuildingBox({
    super.key,
    required this.building,
  });

  final BuildingSummaryModel building;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BuildingCardContent(building: building),
      onTap: () => context.push(AppRouter.kbuildingDetails, extra: building.id),
    );
  }
}
