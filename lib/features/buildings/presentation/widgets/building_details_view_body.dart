import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/floors_section/floors_section_buidler.dart';
import 'package:UpDown/features/buildings/presentation/widgets/header_section/header_section_builder.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/sliver_grid_section_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BuildingDetailsViewBody extends StatelessWidget {
  const BuildingDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBarBuilder(),
        SliverToBoxAdapter(child: const SizedBox(height: 12)),
        BuildingDetailsHeaderSectionBuilder(),
        SliverToBoxAdapter(child: const SizedBox(height: 12)),
        _HeaderSectionBuilder(),
        BuildingFloorsSectionBuilder(),
        SliverToBoxAdapter(child: const SizedBox(height: 12)),
        const ElevatorsSliverGridSectionBuilder(),
      ],
    );
  }
}

class _HeaderSectionBuilder extends StatelessWidget {
  const _HeaderSectionBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingDetailsCubit, BuildingDetailsState>(
      builder: (context, state) {
        return Skeletonizer.sliver(
          enabled: state.status == ContentStatus.loading,
          child: SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              sliver: SliverToBoxAdapter(
                child: HeaderSection(
                  title: "الطوابق",
                  actionText: "عرض الكل",
                  titleStyle: Styles.textStyle18,
                  onActionTap: () {},
                ),
              )),
        );
      },
    );
  }
}

class CustomSliverAppBarBuilder extends StatelessWidget {
  const CustomSliverAppBarBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingDetailsCubit, BuildingDetailsState>(
      builder: (context, state) {
        return Skeletonizer.sliver(
          enabled: state.status == ContentStatus.loading,
          child: CustomSliverAppBar(
            title: state.status == ContentStatus.loaded
                ? state.building!.name
                : "اسم المبنى",
            leading: const BackButtonNavigation(),
          ),
        );
      },
    );
  }
}
