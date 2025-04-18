import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/widgets/custom_animated_button.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/home_widgets/buildings_section/building_box_content.dart';
import 'package:flutter/material.dart';

class BuildingsGridViewBox extends StatelessWidget {
  const BuildingsGridViewBox({
    super.key,
    required this.building,
  });

  final BuildingSummaryModel building;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
      child: BuildingBoxContent(building: building),
      action: () {
        AppRouter.goToBuildingDetails(context, building.id);
      },
    );
  }
}
