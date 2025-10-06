import 'package:UpDown/core/theme/app_spacing.dart';
import 'package:UpDown/features/elevators/data/models/elevator_model.dart';
import 'package:UpDown/features/elevators/presentation/widgets/elevators_section/elevator_card.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

class ElevatorsSection extends StatelessWidget {
  final List<IssueResponseModel> issues;
  const ElevatorsSection(
      {super.key, required this.elevators, required this.issues});

  final List<ElevatorModel> elevators;

  List<Widget> buildElevatorWidgets() {
    return elevators.map((e) {
      final activeIssue =
          issues.firstWhereOrNull((issue) => issue.elevatorId == e.id);
      return ElevatorCard(elevator: e, activeIssue: activeIssue);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.s8,
      children: buildElevatorWidgets(),
    );
  }
}
