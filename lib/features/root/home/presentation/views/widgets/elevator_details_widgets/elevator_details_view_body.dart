import 'package:UpDown/core/utils/status_handler.dart';
import 'package:UpDown/features/root/home/presentation/manager/elevator_cubit/cubit/elevator_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'elevator_details_header_section/elevator_details_header_section.dart';

class ElevatorDetailsViewBody extends StatelessWidget {
  const ElevatorDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<ElevatorCubit, ElevatorState>(builder: (context, state) {
        if (state is ElevatorLoaded && state.elevator.status != "Working") {
          return AlertBanner(
            title: StatusHandler.getStatusDescription(
                status: state.elevator.status,
                issueType: state.elevator
                    .issues[state.elevator.issues.length - 1].issueType,
                nextMaintenanceDate: state.elevator.nextMaintenanceDate),
            color: StatusHandler.getStatusColor(state.elevator.status),
          );
        } else {
          return SizedBox();
        }
      }),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ElevatorDetailsHeaderSection(),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
