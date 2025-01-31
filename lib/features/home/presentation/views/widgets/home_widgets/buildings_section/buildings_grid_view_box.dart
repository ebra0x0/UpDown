import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/widgets/custom_animated_button.dart';
import 'package:UpDown/features/home/data/model/building_summary_model.dart';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'building_box_content.dart';

class BuildingsGridViewBox extends StatelessWidget {
  const BuildingsGridViewBox({
    super.key,
    required this.building,
  });

  final BuildingSummary building;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
      child: BuildingBoxContent(building: building),
      action: () {
        GoRouter.of(context)
            .push(AppRouter.kbuildingDetails, extra: building.buildingId);
      },
    );
  }
}
