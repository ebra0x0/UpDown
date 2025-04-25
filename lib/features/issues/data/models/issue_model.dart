import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/features/issues/data/models/media_model.dart';

class IssueModel {
  final String? id;
  final String? reportId;
  final String elevatorId;
  final String? buildingId;
  final String buildingName;
  final String elevatorName;
  final String description;
  final IssueStatus? status;
  final IssueType issueType;
  final MediaModel? media;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  IssueModel({
    this.id,
    this.reportId,
    required this.elevatorId,
    this.buildingId,
    required this.buildingName,
    required this.elevatorName,
    required this.description,
    required this.issueType,
    this.media,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      id: json['issue_id'],
      reportId: json['report_id'],
      elevatorId: json['elevator_id'],
      buildingId: json['building_id'],
      issueType: IssueTypeExtension.fromString(json['issue_type']),
      media: json['media'],
      elevatorName: json['elevator_name'],
      buildingName: json['building_name'],
      description: json['description'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at']),
      status: json['status'] == null
          ? null
          : IssueStatusExtension.fromString(json['status']),
    );
  }

  IssueModel copyWith({
    String? issueId,
    String? reportId,
    String? elevatorId,
    String? buildingId,
    String? buildingName,
    String? elevatorName,
    MediaModel? media,
    String? description,
    IssueType? issueType,
    IssueStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IssueModel(
      buildingName: buildingName ?? this.buildingName,
      elevatorName: elevatorName ?? this.elevatorName,
      media: media ?? this.media,
      id: issueId ?? id,
      reportId: reportId ?? this.reportId,
      elevatorId: elevatorId ?? this.elevatorId,
      buildingId: buildingId ?? this.buildingId,
      description: description ?? this.description,
      issueType: issueType ?? this.issueType,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'report_id': reportId,
      'elevator_id': elevatorId,
      'description': description,
      'issue_type': IssueTypeExtension.fromIssueType(issueType),
      'building_name': buildingName,
      'elevator_name': elevatorName
    };
  }
}
