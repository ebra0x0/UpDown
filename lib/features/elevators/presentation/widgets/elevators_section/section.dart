import 'package:UpDown/core/theme/app_spacing.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevator_card.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:flutter/widgets.dart';

class ElevatorsSection extends StatelessWidget {
  const ElevatorsSection(
      {super.key, required this.elevators, required this.activeIssue});

  final List<ElevatorModel> elevators;
  final IssueResponseModel? activeIssue;

  List<Widget> buildElevatorWidgets() {
    return elevators
        .map((e) => ElevatorCard(elevator: e, activeIssue: activeIssue))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.s8,
      children: buildElevatorWidgets(),
    );
  }
}
