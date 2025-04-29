import 'package:UpDown/core/widgets/data_loading_shimmer.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevators_grid_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatorsGridSectionBuilder extends StatelessWidget {
  const ElevatorsGridSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElevatorsCubit, ElevatorsState>(
      builder: (context, state) {
        if (state is ElevatorsError) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is ElevatorsLoaded) {
          return ElevatorsGridSection(
            state: state,
          );
        } else if (state is ElevatorsEmpty) {
          return Center(child: Text("لا توجد مصاعد"));
        }
        return DataLoadingIndicator();
      },
    );
  }
}
