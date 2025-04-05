import 'package:UpDown/features/root/home/presentation/manager/elevator_details_cubit/cubit/elevator_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/elevator_details_widgets/elevator_details_header_section/elevator_details_header_section.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/elevator_details_widgets/elevator_details_units_section/elevator_details_units_section.dart';
import 'package:flutter/material.dart';

class ElevatorDetailsViewBody extends StatelessWidget {
  const ElevatorDetailsViewBody({super.key, required this.state});

  final ElevatorDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
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
