import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/home/presentation/manager/buildings_cubit/cubit/buildings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buildings_grid_view_box.dart';
import '../../../../../../../core/widgets/placeholder_panel.dart';

class BuildingsGridView extends StatelessWidget {
  const BuildingsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsCubitState>(
        builder: (context, state) {
      if (state is BuildingsCubitEmpty) {
        return PlaceholderPanel(message: "لا يوجد عقارات مسجلة");
      } else if (state is BuildingsCubitError) {
        print(state.error);
        return PlaceholderPanel(message: "حدث خطأ ما وجاري حل المشكلة");
      } else if (state is BuildingsCubitSuccess) {
        // print(state.buildings[0]);
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 16,
            ),
            itemCount: state.buildings.length,
            itemBuilder: (context, index) {
              return BuildingsGridViewBox(building: state.buildings[index]);
            });
      }
      return LoadingIndicator();
    });
  }
}
