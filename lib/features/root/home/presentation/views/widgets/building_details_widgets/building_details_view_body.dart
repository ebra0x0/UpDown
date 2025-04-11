import 'package:UpDown/features/root/home/presentation/manager/building_details_cubit/cubit/building_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/building_details_elevators_section.dart';
import 'package:flutter/material.dart';

import 'building_details_header_section/building_details_header_section.dart';

class BuildingDetailsViewBody extends StatelessWidget {
  const BuildingDetailsViewBody({super.key, required this.state});

  final BuildingDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: BuildingDetailsHeaderSection(
            state: state,
          )),
          SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
          SliverFillRemaining(
            child: BuildingDetailsElevatorsSection(
              state: state,
            ),
          ),
        ],
      ),
    );
  }
}
