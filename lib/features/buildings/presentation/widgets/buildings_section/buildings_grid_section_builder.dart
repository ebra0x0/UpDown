import 'package:UpDown/core/widgets/data_loading_shimmer.dart';
import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/buildings_section/buildings_grid_view_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingsGridSectionBuilder extends StatelessWidget {
  const BuildingsGridSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsState>(
        builder: (context, state) {
      if (state is BuildingsLoaded) {
        return BuildingsGridViewSection(state: state);
      } else if (state is BuildingsError) {
        return SliverToBoxAdapter(child: Text(state.error));
      } else if (state is BuildingsEmpty) {
        return SliverToBoxAdapter(
            child: Center(child: Text("لا يوجد مباني مسجلة")));
      }
      return SliverToBoxAdapter(child: DataLoadingIndicator());
    });
  }
}
