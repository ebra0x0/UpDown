import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/building_card_content.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class BuildingCard extends StatelessWidget {
  const BuildingCard({
    super.key,
    required this.building,
  });

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BuildingCardContent(building: building),
      onTap: () {
        context.push(
          "${AppRoute.home.path}${AppRoute.building.path}/${building.id}",
        );
      },
    );
  }
}
