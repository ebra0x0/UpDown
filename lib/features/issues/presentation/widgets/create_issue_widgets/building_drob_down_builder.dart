import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/building_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDropDownBuilder extends StatelessWidget {
  const BuildingDropDownBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsState>(
        builder: (context, state) {
      return BuildingDropdown(
        onChanged: (BuildingSummaryModel? building) {
          if (building == null) return;
          context.read<CreateIssueCubit>().selectBuilding(building);
        },
        isLoading: state is BuildingsLoading,
        buildings: state is BuildingsLoaded ? state.buildings : null,
        selectedBuilding: context.watch<CreateIssueCubit>().selectedBuilding,
      );
    });
  }
}
