import 'package:UpDown/core/widgets/attributes_section.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/home/data/model/attribute_model.dart';
import 'package:UpDown/features/root/home/presentation/manager/building_details_cubit/cubit/building_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDetailsHeaderSection extends StatelessWidget {
  const BuildingDetailsHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingDetailsCubit, BuildingDetailsState>(
      builder: (context, state) {
        if (state is BuildingDetailsLoaded) {
          return Column(children: [
            Text(
              state.building!.name,
              style: Styles.textStyle26,
            ),
            SizedBox(height: 16),
            AttributesSection(attributes: [
              AttributeModel(
                  icon: Icons.assignment_late_outlined,
                  text: state.building!.reports == null
                      ? "0"
                      : state.building!.reports!.length.toString()),
              AttributeModel(
                  icon: Icons.stairs_outlined,
                  text: state.building!.floors.length.toString()),
              AttributeModel(
                  icon: Icons.elevator_outlined,
                  text: state.building!.elevators.length.toString()),
            ])
          ]);
        } else if (state is BuildingDetailsLoading) {
          return const Center(
            child: DataLoadingIndicator(),
          );
        } else if (state is BuildingDetailsError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: DataLoadingIndicator(),
          );
        }
      },
    );
  }
}
