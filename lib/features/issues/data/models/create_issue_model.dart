import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/issues/data/models/media_model.dart';

class CreateIssueModel {
  final String? id;
  final String? reportId;
  final IssueType issueType;
  final String? description;
  final IssuePriority priority;
  final MediaModel? media;
  final String buildingId;
  final String elevatorId;
  final String buildingName;
  final String elevatorName;

  const CreateIssueModel({
    this.id,
    this.reportId,
    required this.issueType,
    this.description,
    required this.priority,
    required this.media,
    required this.buildingId,
    required this.elevatorId,
    required this.buildingName,
    required this.elevatorName,
  });

  CreateIssueModel copyWith({
    String? id,
    String? reportId,
    IssueType? issueType,
    String? description,
    IssuePriority? priority,
    MediaModel? media,
    String? buildingId,
    String? elevatorId,
    String? buildingName,
    String? elevatorName,
  }) {
    return CreateIssueModel(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      issueType: issueType ?? this.issueType,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      media: media ?? this.media,
      buildingId: buildingId ?? this.buildingId,
      elevatorId: elevatorId ?? this.elevatorId,
      buildingName: buildingName ?? this.buildingName,
      elevatorName: elevatorName ?? this.elevatorName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "building_id": buildingId,
      "elevator_id": elevatorId,
      "description": description,
      "issue_type": issueType.name,
      "building_name": buildingName,
      "elevator_name": elevatorName,
      "priority": priority.name,
    };
  }
}
