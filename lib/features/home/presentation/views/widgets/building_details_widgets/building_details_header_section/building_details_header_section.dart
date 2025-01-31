import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/home/presentation/manager/buildings_cubit/cubit/buildings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'building_attributes_box.dart';

class BuildingDetailsHeaderSection extends StatelessWidget {
  const BuildingDetailsHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsState>(
      builder: (context, state) {
        if (state is BuildingsLoaded) {
          return Column(children: [
            Text(
              state.building!.name,
              style: Styles.textStyle26,
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 80,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BuildingAttributesBox(
                      icon: Icons.location_on_outlined,
                      text: state.building!.address,
                    ),
                    BuildingAttributesBox(
                      icon: Icons.stairs_outlined,
                      text: state.building!.floorCount.toString(),
                    ),
                    BuildingAttributesBox(
                      icon: Icons.elevator_outlined,
                      text: state.building!.elevators.length.toString(),
                    ),
                  ]),
            )
          ]);
        } else if (state is BuildingsLoading) {
          return const Center(
            child: LoadingIndicator(),
          );
        } else if (state is BuildingsError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: LoadingIndicator(),
          );
        }
      },
    );
  }
}
