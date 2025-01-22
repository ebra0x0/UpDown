import 'package:UpDown/core/utils/model/building_model.dart';
import 'package:flutter/widgets.dart';

import 'building_details_header_section/building_details_info_section.dart';

class BuildingDetailsViewBody extends StatelessWidget {
  const BuildingDetailsViewBody({super.key, required this.building});

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, top: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BuildingDetailsInfoSection(
              building: building,
            ),
          ),
        ],
      ),
    );
  }
}
