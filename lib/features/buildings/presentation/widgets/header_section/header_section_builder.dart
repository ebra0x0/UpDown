import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:UpDown/features/buildings/presentation/widgets/header_section/header_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BuildingDetailsHeaderSectionBuilder extends StatelessWidget {
  const BuildingDetailsHeaderSectionBuilder({
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
        return SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            sliver: Skeletonizer.sliver(
              enabled: state.status == ContentStatus.loading,
              child: BuildingDetailsHeaderSection(
                building: state.status == ContentStatus.loaded
                    ? state.building!
                    : BuildingModel.empty(),
              ),
            ));
      },
    );
  }
}
