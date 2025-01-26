import 'package:UpDown/features/home/data/model/building_model.dart';
import 'package:UpDown/features/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/building_details_elevators_section.dart';
import 'package:flutter/widgets.dart';

import 'building_details_header_section/building_details_header_section.dart';

class BuildingDetailsViewBody extends StatelessWidget {
  const BuildingDetailsViewBody({super.key, required this.building});

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BuildingDetailsHeaderSection(
              building: building,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 26),
          ),
          SliverFillRemaining(
            child: BuildingDetailsElevatorsSection(
              elevators: building.elevators,
            ),
          ),
        ],
      ),
    );
  }
}
