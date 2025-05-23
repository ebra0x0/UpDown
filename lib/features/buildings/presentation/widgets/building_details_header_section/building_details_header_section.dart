import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:flutter/material.dart';

class BuildingDetailsHeaderSection extends StatelessWidget {
  const BuildingDetailsHeaderSection({super.key, required this.state});

  final BuildingDetailsLoaded state;

  List<Map<String, dynamic>> get attributes => [
        {
          'icon': Styles.reportIcon.icon,
          'title': state.building.reports.isEmpty
              ? "0"
              : state.building.reports.length.toString()
        },
        {
          'icon': Styles.stairsIcon.icon,
          'title': state.building.floors.length.toString()
        },
        {
          'icon': Styles.elevatorIcon.icon,
          'title': state.building.elevators.length.toString()
        },
      ];

  @override
  Widget build(BuildContext context) {
    return AttributesSection(attributes: attributes);
  }
}
