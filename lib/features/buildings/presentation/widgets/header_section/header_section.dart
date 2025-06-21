import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:flutter/widgets.dart';

class BuildingDetailsHeaderSection extends StatelessWidget {
  const BuildingDetailsHeaderSection({super.key, required this.building});

  final BuildingModel building;

  List<Map<String, dynamic>> get attributes => [
        {
          'name': 'التقارير',
          'icon': Styles.reportIcon,
          'value': building.reportsCount.toString(),
        },
        {
          'name': 'الطوابق',
          'icon': Styles.stairsIcon,
          'value': building.floors.length.toString(),
        },
        {
          'name': 'المصاعد',
          'icon': Styles.elevatorIcon,
          'value': building.elevatorsCount.toString(),
        },
      ];

  @override
  Widget build(BuildContext context) {
    return AttributesSection(
      attributes: attributes,
    );
  }
}
