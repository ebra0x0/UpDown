import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:equatable/equatable.dart';

class IssueSummaryModel extends Equatable {
  final String id;
  final String userId;
  final String buildingId;
  final String elevatorId;
  final String buildingName;
  final String elevatorName;
  final IssueType issueType;
  final IssueStatus status;
  final IssuePriority priority;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const IssueSummaryModel({
    required this.id,
    required this.userId,
    required this.buildingId,
    required this.elevatorId,
    required this.buildingName,
    required this.elevatorName,
    required this.issueType,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IssueSummaryModel.fromJson(Map<String, dynamic> json) {
    return IssueSummaryModel(
      id: json['id'],
      userId: json['user_id'],
      elevatorId: json['elevator_id'],
      buildingId: json['building_id'],
      issueType: IssueType.values.firstWhere(
        (issueType) => issueType.name == json['issue_type'],
        orElse: () => IssueType.other,
      ),
      buildingName: json['building_name'],
      elevatorName: json['elevator_name'],
      status: IssueStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => IssueStatus.notFixed,
      ),
      priority: IssuePriority.values.firstWhere(
        (priority) => priority.name == json['priority'],
        orElse: () => IssuePriority.low,
      ),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        buildingId,
        elevatorId,
        buildingName,
        elevatorName,
        issueType,
        status,
        priority,
        createdAt,
        updatedAt,
      ];
}
