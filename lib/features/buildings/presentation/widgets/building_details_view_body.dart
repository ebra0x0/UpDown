import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/features/buildings/presentation/cubits/building_details_cubit/building_details_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/floors_section/floors_section_buidler.dart';
import 'package:UpDown/features/buildings/presentation/widgets/header_section/header_section_builder.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/section_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDetailsViewBody extends StatelessWidget {
  const BuildingDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<BuildingDetailsCubit, BuildingDetailsState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) => CustomSliverAppBar(
                  isLoading: state.status == ContentStatus.loading,
                  title: state.building?.name ?? "اسم المبنى",
                )),
        SliverToBoxAdapter(child: const SizedBox(height: 12)),
        BuildingDetailsHeaderSectionBuilder(),
        SliverToBoxAdapter(child: const SizedBox(height: 12)),
        SliverPadding(
            padding: AppInsets.h8, sliver: BuildingFloorsSectionBuilder()),
        SliverToBoxAdapter(child: const SizedBox(height: 12)),
        const ElevatorsSectionBuilder(),
      ],
    );
  }
}
