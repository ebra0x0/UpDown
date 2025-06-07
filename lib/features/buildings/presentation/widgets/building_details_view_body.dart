import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/building_floors_section/building_floors_section.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevators_grid_section_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          leading: const BackButtonNavigation(),
          title: Text(state.building.name,
              style: Styles.textStyle22,
              overflow: TextOverflow.ellipsis,
              maxLines: 1),
          centerTitle: true,
        ),
        SliverToBoxAdapter(child: const SizedBox(height: 12)),
        SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            sliver: BuildingDetailsHeaderSection(
              state: state,
            )),
        SliverToBoxAdapter(child: const SizedBox(height: 12)),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          sliver: const ElevatorsGridSectionBuilder(),
        ),
        SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            sliver: SliverToBoxAdapter(
                child: HeaderSection(
              title: "الطوابق",
              actionText: "عرض الكل",
              titleStyle: Styles.textStyle18,
              onActionTap: () {},
            ))),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          sliver: BuildingFloorsSection(
            floors: state.building.floors,
          ),
        ),
      ],
    );
  }
}
