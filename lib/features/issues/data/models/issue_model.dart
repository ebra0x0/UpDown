import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/issues/data/models/media_model.dart';

class IssueModel {
  final String id;
  final String userId;
  final String reportId;
  final String buildingId;
  final String elevatorId;
  final String buildingName;
  final String elevatorName;
  final String? description;
  final IssueType issueType;
  final IssuePriority priority;
  final IssueStatus status;
  final MediaModel? media;
  final int? cost;
  final String? technicianNote;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? resolvedAt;

  IssueModel({
    required this.id,
    required this.reportId,
    required this.elevatorId,
    required this.buildingId,
    required this.buildingName,
    required this.elevatorName,
    required this.description,
    required this.issueType,
    this.media,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.priority,
    this.cost,
    this.technicianNote,
    this.resolvedAt,
    required this.userId,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      id: json['id'],
      userId: json['user_id'],
      reportId: json['report_id'],
      elevatorId: json['elevator_id'],
      buildingId: json['building_id'],
      issueType: IssueType.values.firstWhere(
        (type) => type.name == json['issue_type'],
        orElse: () => IssueType.other,
      ),
      media: json['media'],
      elevatorName: json['elevator_name'],
      buildingName: json['building_name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt:
          json['updated_at'] ?? DateTime.tryParse(json['updated_at'] ?? ''),
      status: IssueStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => IssueStatus.notFixed,
      ),
      priority: IssuePriority.values.firstWhere(
        (priority) => priority.name == json['priority'],
        orElse: () => IssuePriority.low,
      ),
      cost: json['cost'],
      technicianNote: json['technician_note'],
      resolvedAt:
          json['resolved_at'] ?? DateTime.tryParse(json['resolved_at'] ?? ''),
    );
  }

  IssueModel copyWith({
    String? id,
    String? userId,
    String? reportId,
    String? elevatorId,
    String? buildingId,
    String? buildingName,
    String? elevatorName,
    MediaModel? media,
    String? description,
    IssueType? issueType,
    IssueStatus? status,
    IssuePriority? priority,
    int? cost,
    String? technicianNote,
    DateTime? updatedAt,
    DateTime? createdAt,
    DateTime? resolvedAt,
  }) {
    return IssueModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      buildingName: buildingName ?? this.buildingName,
      elevatorName: elevatorName ?? this.elevatorName,
      media: media ?? this.media,
      reportId: reportId ?? this.reportId,
      elevatorId: elevatorId ?? this.elevatorId,
      buildingId: buildingId ?? this.buildingId,
      description: description ?? this.description,
      issueType: issueType ?? this.issueType,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      priority: priority ?? this.priority,
      cost: cost ?? this.cost,
      technicianNote: technicianNote ?? this.technicianNote,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'report_id': reportId,
      'building_id': buildingId,
      'elevator_id': elevatorId,
      'description': description,
      'issue_type': issueType.name,
      'building_name': buildingName,
      'elevator_name': elevatorName,
      'priority': priority.name,
    };
  }
}
