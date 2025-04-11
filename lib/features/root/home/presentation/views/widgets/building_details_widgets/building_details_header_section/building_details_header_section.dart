import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/home/data/model/attribute_model.dart';
import 'package:UpDown/features/root/home/presentation/manager/building_details_cubit/cubit/building_details_cubit.dart';
import 'package:flutter/material.dart';

class BuildingDetailsHeaderSection extends StatelessWidget {
  const BuildingDetailsHeaderSection({super.key, required this.state});

  final BuildingDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        state.building!.name,
        style: Styles.textStyle26,
      ),
      SizedBox(height: 16),
      AttributesSection(attributes: [
        AttributeModel(
            icon: Icons.assignment_late_outlined,
            text: state.building!.reports == null
                ? "0"
                : state.building!.reports!.length.toString()),
        AttributeModel(
            icon: Icons.stairs_outlined,
            text: state.building!.floors.length.toString()),
        AttributeModel(
            icon: Icons.elevator_outlined,
            text: state.building!.elevators.length.toString()),
      ])
    ]);
  }
}
