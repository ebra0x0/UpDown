import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevators_grid_section_builder.dart';
import 'package:flutter/material.dart';

import 'building_details_header_section/building_details_header_section.dart';

class BuildingDetailsViewBody extends StatelessWidget {
  const BuildingDetailsViewBody({super.key, required this.state});

  final BuildingDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          leading: BackButtonNavigation(),
          title: Text(state.building.name, style: Styles.textStyle26),
          centerTitle: true,
        ),
        SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: BuildingDetailsHeaderSection(
                state: state,
              ),
            )),
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverFillRemaining(
            child: ElevatorsGridSectionBuilder(),
          ),
        ),
      ],
    );
  }
}
