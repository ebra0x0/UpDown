import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevators_grid_section_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'building_details_header_section/building_details_header_section.dart';

class BuildingDetailsViewBody extends StatelessWidget {
  const BuildingDetailsViewBody({super.key, required this.buildingState});

  final BuildingDetailsLoaded buildingState;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 22,
              )),
          title: Text(buildingState.building.name, style: Styles.textStyle26),
          centerTitle: true,
        ),
        SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: BuildingDetailsHeaderSection(
                state: buildingState,
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
