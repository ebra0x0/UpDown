import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:flutter/material.dart';

class BuildingDetailsHeaderSection extends StatelessWidget {
  const BuildingDetailsHeaderSection({super.key, required this.state});

  final BuildingDetailsLoaded state;

  BuildingModel get building => state.building;

  List<Map<String, dynamic>> get attributes => [
        {
          'name': 'التقارير',
          'icon': Styles.reportIcon,
          'value': state.building.reports.isEmpty
              ? "0"
              : building.reports.length.toString()
        },
        {
          'name': 'الطوابق',
          'icon': Styles.stairsIcon,
          'value': building.floors.length.toString()
        },
        {
          'name': 'المصاعد',
          'icon': Styles.elevatorIcon,
          'value': building.elevators.length.toString()
        },
      ];

  @override
  Widget build(BuildContext context) {
    return AttributesSection(attributes: attributes);
  }
}
