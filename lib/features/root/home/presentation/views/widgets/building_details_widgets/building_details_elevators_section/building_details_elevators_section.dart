import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/root/home/presentation/manager/buildings_cubit/cubit/buildings_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/building_elevators_box.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDetailsElevatorsSection extends StatelessWidget {
  const BuildingDetailsElevatorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsState>(
        builder: (context, state) {
      if (state is BuildingsLoaded) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1 / .75),
          itemCount: state.building!.elevators.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return BuildingElevatorsBox(
              elevator: state.building!.elevators[index],
            );
          },
        );
      } else if (state is BuildingsError) {
        return Center(
          child: Text(state.error),
        );
      } else if (state is BuildingsLoading) {
        return Center(
          child: DataLoadingIndicator(),
        );
      } else {
        return Container();
      }
    });
  }
}
