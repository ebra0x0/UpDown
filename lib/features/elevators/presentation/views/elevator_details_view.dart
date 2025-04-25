import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/core/widgets/custom_error.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/elevator_details_view_body.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ElevatorDetailsCubit, ElevatorDetailsState>(
            builder: (context, state) {
          if (state is ElevatorDetailsLoaded) {
            return ElevatorDetailsViewBody(state: state);
          } else if (state is ElevatorDetailsError) {
            return CustomError(errorMessage: state.error);
          }
          return const DataLoadingIndicator();
        }),
      ),
    );
  }
}
