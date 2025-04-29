import 'package:UpDown/features/elevators/presentation/widgets/elevator_drob_down.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatorDrobDownBuilder extends StatelessWidget {
  const ElevatorDrobDownBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CreateIssueCubit>();
    return SizedBox(
      height: 64,
      child: ElevatorDropdown(
          isLoading: cubit.state is SelectLoading,
          elevators: cubit.elevators,
          selectedElevator: cubit.selectedElevator),
    );
  }
}
