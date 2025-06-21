import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:equatable/equatable.dart';

class ElevatorSummaryModel extends Equatable {
  final String id;
  final String buildingId;
  final String name;
  final String buildingName;
  final ElevatorStatus status;
  final IssueType? issueType;
  final DateTime? issueDate;

  const ElevatorSummaryModel({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.buildingName,
    required this.status,
    this.issueType,
    this.issueDate,
  });

  factory ElevatorSummaryModel.fromJson(Map<String, dynamic> json) {
    final bool hasIssue = json["active_issue"] != null;

    return ElevatorSummaryModel(
      id: json["id"],
      buildingId: json["building_id"],
      name: json["name"],
      buildingName: json["building_name"],
      status: ElevatorStatus.values.firstWhere(
        (status) => status.name == json["status"],
        orElse: () => ElevatorStatus.working,
      ),
      issueType: hasIssue
          ? IssueType.values.firstWhere(
              (type) => type.name == json['active_issue']['issue_type'],
              orElse: () => IssueType.other,
            )
          : null,
      issueDate: hasIssue
          ? DateTime.parse(
              json["active_issue"]["issue_date"],
            )
          : null,
    );
  }

  factory ElevatorSummaryModel.empty() => const ElevatorSummaryModel(
        id: "",
        buildingId: "",
        name: "",
        buildingName: "",
        status: ElevatorStatus.working,
        issueType: null,
        issueDate: null,
      );

  @override
  List<Object?> get props => [
        id,
        buildingId,
        name,
        buildingName,
        status,
        issueType,
        issueDate,
      ];
}
