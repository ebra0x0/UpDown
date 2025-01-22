import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/home/presentation/manager/buildings_cubit/cubit/buildings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buildings_grid_view_box.dart';
import 'buildings_grid_view_error.dart';

class BuildingsGridView extends StatelessWidget {
  const BuildingsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsCubitState>(
        builder: (context, state) {
      if (state is BuildingsCubitEmpty) {
        return BuildingsGridViewError(
          errorMsg: "لا يوجد عقارات مسجلة",
        );
      } else if (state is BuildingsCubitError) {
        return BuildingsGridViewError(errorMsg: "حدث خطأ ما وجاري حل المشكلة");
      } else if (state is BuildingsCubitLoading ||
          state is BuildingsCubitInitial) {
        return LoadingIndicator();
      }
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
        ),
        itemCount: 1,
        itemBuilder: (context, index) {
          return BlocBuilder<BuildingsCubit, BuildingsCubitState>(
              builder: (context, state) {
            if (state is BuildingsCubitSuccess) {
              return BuildingsGridViewBox(building: state.buildings[index]);
            } else {
              return Container();
            }
          });
        },
      );
    });
  }
}
