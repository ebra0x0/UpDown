import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';

class ElevatorSummaryModel {
  final String id;
  final ElevatorStatus status;
  final String name;
  final IssueType? issueType;

  ElevatorSummaryModel({
    required this.id,
    required this.name,
    required this.issueType,
    required this.status,
  });

  factory ElevatorSummaryModel.fromJson(Map<String, dynamic> json) {
    return ElevatorSummaryModel(
      issueType:
          IssueTypeExtension.fromString(json["active_issue"]["issue_type"]),
      id: json["elevator_id"],
      name: json["elevator_name"],
      status: ElevatorStatusExtension.fromString(json["status"]),
    );
  }
}
