import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_header_section/elevator_details_header_section.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_units_section/elevator_details_units_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ElevatorDetailsViewBody extends StatelessWidget {
  const ElevatorDetailsViewBody({super.key, required this.state});

  final ElevatorDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 22,
              )),
          title: Text(state.elevator.name, style: Styles.textStyle26),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: ElevatorDetailsHeaderSection(state: state),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 36)),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: ElevatorDetailsUnitSection(state: state),
        )
      ],
    );
  }
}
