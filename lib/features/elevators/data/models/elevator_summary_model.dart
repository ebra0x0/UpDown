import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';

class ElevatorSummaryModel {
  final String id;
  final String buildingId;
  final ElevatorStatus status;
  final String name;
  final IssueType? issueType;

  ElevatorSummaryModel({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.issueType,
    required this.status,
  });

  factory ElevatorSummaryModel.fromJson(Map<String, dynamic> json) {
    return ElevatorSummaryModel(
      id: json["elevator_id"],
      buildingId: json["building_id"],
      issueType: json["active_issue"] == null
          ? null
          : IssueTypeExtension.fromString(json["active_issue"]["issue_type"]),
      name: json["elevator_name"],
      status: ElevatorStatusExtension.fromString(json["status"]),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ElevatorSummaryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
