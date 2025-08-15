import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/buildings/presentation/cubits/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/sliver_grid_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingsSliverGridSectionBuilder extends StatelessWidget {
  const BuildingsSliverGridSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.status == ContentStatus.error) {
            return SliverToBoxAdapter(
              child: ScreenEcho(message: state.errorMsg!),
            );
          } else if (state.status == ContentStatus.empty) {
            return SliverToBoxAdapter(
              child: ScreenEcho(message: "لا توجد مباني مسجلة حتى الآن"),
            );
          }
          return AppSkeletonizer(
            enabled: state.status == ContentStatus.loading,
            isSliver: true,
            child: BuildingsSliverGridViewSection(
              buildings: state.buildings ?? [],
            ),
          );
        });
  }
}
