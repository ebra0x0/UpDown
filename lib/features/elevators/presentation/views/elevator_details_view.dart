import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/core/widgets/data_loading_shimmer.dart';
import 'package:UpDown/core/widgets/placeholder_panel.dart';
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
    return BlocBuilder<ElevatorDetailsCubit, ElevatorDetailsState>(
      builder: (context, state) {
        return Scaffold(
            appBar: state is ElevatorDetailsLoaded
                ? null
                : AppBar(
                    leading: BackButtonNavigation(),
                  ),
            body: () {
              if (state is ElevatorDetailsLoaded) {
                return ElevatorDetailsViewBody(state: state);
              } else if (state is ElevatorDetailsError) {
                return PlaceholderPanel(message: state.error);
              }
              return const DataLoadingIndicator();
            }());
      },
    );
  }
}
