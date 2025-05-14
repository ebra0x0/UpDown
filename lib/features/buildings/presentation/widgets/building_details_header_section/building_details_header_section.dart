import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:flutter/material.dart';

class BuildingDetailsHeaderSection extends StatelessWidget {
  const BuildingDetailsHeaderSection({super.key, required this.state});

  final BuildingDetailsLoaded state;

  List<Map<String, dynamic>> get attributes => [
        {
          'icon': Icons.assignment_late_outlined,
          'text': state.building.reports.isEmpty
              ? "0"
              : state.building.reports.length.toString()
        },
        {
          'icon': Icons.stairs_outlined,
          'text': state.building.floors.length.toString()
        },
        {
          'icon': Icons.elevator_outlined,
          'text': state.building.elevators.length.toString()
        },
      ];

  @override
  Widget build(BuildContext context) {
    return AttributesSection(attributes: attributes);
  }
}
