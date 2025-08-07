import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/presentation/widgets/floors_section/floors_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/features/buildings/presentation/cubits/building_details_cubit/building_details_cubit.dart';

class BuildingFloorsSectionBuilder extends StatelessWidget {
  const BuildingFloorsSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingDetailsCubit, BuildingDetailsState>(
      builder: (context, state) {
        final floors = state.status == ContentStatus.loaded
            ? state.building!.floors
            : List.generate(2, (_) => FloorModel.empty());

        return AppSkeletonizer(
            isSliver: true,
            enabled: state.status == ContentStatus.loading,
            child: SliverList(
                delegate: SliverChildListDelegate([
              Visibility(
                visible: floors.isNotEmpty,
                child: HeaderSection(
                  title: "الطوابق",
                  titleStyle: AppTextStyles.textStyle18,
                ),
              ),
              BuildingFloorsSection(
                floors: floors,
              ),
            ])));
      },
    );
  }
}
