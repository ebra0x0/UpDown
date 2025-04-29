import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/building_drob_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDrobDownBuilder extends StatelessWidget {
  const BuildingDrobDownBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: BlocBuilder<BuildingsCubit, BuildingsState>(
          builder: (context, state) {
        return BuildingDropdown(
          isLoading: state is BuildingsLoading,
          buildings: state is BuildingsLoaded ? state.buildings : null,
          selectedBuilding: context.watch<CreateIssueCubit>().selectedBuilding,
        );
      }),
    );
  }
}
