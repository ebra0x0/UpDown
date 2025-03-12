import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/core/widgets/placeholder_panel.dart';
import 'package:UpDown/features/root/home/presentation/manager/buildings_summary_cubit/cubit/buildings_summary_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buildings_grid_view_box.dart';

class BuildingsGridViewSection extends StatelessWidget {
  const BuildingsGridViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsSummaryCubit, BuildingsSummaryState>(
      builder: (context, state) {
        return state is BuildingsSummaryEmpty
            ? PlaceholderPanel(message: "لا يوجد عقارات مسجلة")
            : state is BuildingsSummaryError
                ? PlaceholderPanel(message: "حدث خطأ ما وجاري حل المشكلة")
                : state is BuildingsSummaryLoaded
                    ? SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1 / .75),
                        itemCount: state.buildingsSummary.length,
                        itemBuilder: (context, index) {
                          return BuildingsGridViewBox(
                              building: state.buildingsSummary[index]);
                        })
                    : DataLoadingIndicator();
      },
    );
  }
}
