import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevator_details_cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_active_Issue.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevator_details_units_section/elevator_details_units_section.dart';
import 'package:flutter/material.dart';

class ElevatorDetailsViewBody extends StatelessWidget {
  const ElevatorDetailsViewBody({super.key, required this.state});

  final ElevatorDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          leading: BackButtonNavigation(),
          title: Text(
            "المصعد ${state.elevator.name}",
            style: Styles.textStyle24,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          centerTitle: true,
        ),
        SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
                child: Visibility(
                    visible: state.elevator.activeIssue != null,
                    child: ElevatorDetailsActiveIssue(state: state)))),
        SliverToBoxAdapter(child: SizedBox(height: 36)),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: ElevatorDetailsUnitSection(state: state),
        )
      ],
    );
  }
}
