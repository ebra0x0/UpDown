import 'package:flutter/material.dart';
import 'widgets/elevator_details_widgets/elevator_details_view_body.dart';

class ElevatorDetailsView extends StatelessWidget {
  const ElevatorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: ElevatorDetailsViewBody()));
  }
}
