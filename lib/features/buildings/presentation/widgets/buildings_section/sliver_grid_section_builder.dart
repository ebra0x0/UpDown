import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/sliver_grid_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BuildingsSliverGridSectionBuilder extends StatelessWidget {
  const BuildingsSliverGridSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsState>(
        builder: (context, state) {
      if (state.status == BuildingsStates.error) {
        return SliverToBoxAdapter(child: ScreenEcho(message: state.errorMsg!));
      }
      return Skeletonizer.sliver(
        enabled: state.status == BuildingsStates.loading,
        child: BuildingsSliverGridViewSection(
          buildings:
              state.status == BuildingsStates.loaded ? state.buildings! : [],
        ),
      );
    });
  }
}
