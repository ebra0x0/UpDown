import 'package:flutter/material.dart';
import 'elevator_details_header_section/elevator_details_header_section.dart';

class ElevatorDetailsViewBody extends StatelessWidget {
  const ElevatorDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ElevatorDetailsHeaderSection(),
        ),
      ],
    );
  }
}
