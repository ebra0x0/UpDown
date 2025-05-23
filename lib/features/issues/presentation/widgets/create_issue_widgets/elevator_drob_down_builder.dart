import 'package:UpDown/features/elevators/presentation/widgets/elevator_drop_down.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatorDropDownBuilder extends StatelessWidget {
  const ElevatorDropDownBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIssueCubit, CreateIssueState>(
      builder: (context, state) {
        return ElevatorDropdown(
          onChanged: (elevator) {
            if (elevator == null) return;
            context.read<CreateIssueCubit>().selectElevator(elevator);
          },
          isLoading: state is CreateIssueLoading,
          elevators: context.read<CreateIssueCubit>().elevators,
          selectedElevator: context.read<CreateIssueCubit>().selectedElevator,
        );
      },
    );
  }
}
