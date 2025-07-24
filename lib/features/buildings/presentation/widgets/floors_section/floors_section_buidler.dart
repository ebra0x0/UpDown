import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/presentation/widgets/floors_section/floors_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/buildings/presentation/cubits/building_details_cubit/building_details_cubit.dart';

class BuildingFloorsSectionBuilder extends StatelessWidget {
  const BuildingFloorsSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingDetailsCubit, BuildingDetailsState>(
      builder: (context, state) {
        if (state.status == ContentStatus.error) {
          return SliverToBoxAdapter(
              child: ScreenEcho(message: state.errorMsg!));
        }
        return AppSkeletonizer(
          isSliver: true,
          enabled: state.status == ContentStatus.loading,
          child: SliverPadding(
            padding: AppInsets.h8,
            sliver: BuildingFloorsSection(
              floors: state.status == ContentStatus.loaded
                  ? state.building!.floors
                  : List.generate(4, (_) => FloorModel.empty()),
            ),
          ),
        );
      },
    );
  }
}
