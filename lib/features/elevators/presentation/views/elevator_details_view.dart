import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo_imp.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_units_cubit/elevator_units_cubit.dart';
import 'package:UpDown/core/utils/manager/active_issues_cubit/active_issues_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatorDetailsView extends StatefulWidget {
  const ElevatorDetailsView({super.key, required this.elevatorId});

  final String elevatorId;

  @override
  State<ElevatorDetailsView> createState() => _ElevatorDetailsViewState();
}

class _ElevatorDetailsViewState extends State<ElevatorDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<ElevatorDetailsCubit>().call(elevatorId: widget.elevatorId);
    context
        .read<ActiveIssuesCubit>()
        .fetchAllActiveForElevator(widget.elevatorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ElevatorUnitsCubit(gitIt.get<ElevatorRepoImp>())
          ..call(widget.elevatorId),
        child: ElevatorDetailsViewBody(
          elevatorId: widget.elevatorId,
        ),
      ),
    );
  }
}
