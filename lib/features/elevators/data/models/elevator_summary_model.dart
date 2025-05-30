import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/localization/local_service.dart';
import 'package:intl/intl.dart';

class ElevatorSummaryModel {
  final String id;
  final String buildingId;
  final ElevatorStatus status;
  final String name;
  final IssueType? issueType;
  final String? issueDate;

  ElevatorSummaryModel({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.status,
    this.issueType,
    this.issueDate,
  });

  factory ElevatorSummaryModel.fromJson(Map<String, dynamic> json) {
    final bool hasIssue = json["active_issue"] != null;
    final DateTime? issueDate = hasIssue
        ? DateTime.parse(json["active_issue"]["updated_at"] ??
            json["active_issue"]["created_at"])
        : null;
    final String locale = LocaleService.currentLocale;

    return ElevatorSummaryModel(
      id: json["elevator_id"],
      buildingId: json["building_id"],
      issueType: hasIssue
          ? json["active_issue"]["issue_type"].runtimeType == String
              ? IssueTypeExtension.fromString(
                  json["active_issue"]["issue_type"])
              : json["active_issue"]["issue_type"]
          : null,
      issueDate: issueDate != null
          ? DateFormat('d MMMM, hh:mm a', locale).format(issueDate)
          : null,
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
