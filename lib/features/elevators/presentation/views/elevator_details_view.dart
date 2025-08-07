import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_view_body.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatorDetailsView extends StatefulWidget {
  final String elevatorId;

  const ElevatorDetailsView({super.key, required this.elevatorId});

  @override
  State<ElevatorDetailsView> createState() => _ElevatorDetailsViewState();
}

class _ElevatorDetailsViewState extends State<ElevatorDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<ElevatorDetailsCubit>().call(elevatorId: widget.elevatorId);
    context
        .read<IssuesCubit>()
        .emitStreamAllActiveForElevator(widget.elevatorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatorDetailsViewBody(),
    );
  }
}
