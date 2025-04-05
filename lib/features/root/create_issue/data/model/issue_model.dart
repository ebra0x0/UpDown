import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';

class IssueModel {
  final String? issueId;
  final String? reportId;
  final String elevatorId;
  final String? buildingId;
  final String buildingName;
  final String elevatorName;
  final String description;
  final IssueStatus status;
  final IssueType issueType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  IssueModel({
    this.issueId,
    this.reportId,
    required this.elevatorId,
    this.buildingId,
    required this.buildingName,
    required this.elevatorName,
    required this.description,
    required this.issueType,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      issueId: json['issue_id'],
      reportId: json['report_id'],
      issueType: IssueTypeExtension.fromString(json['issue_type']),
      description: json['description'],
      elevatorId: json['elevator_id'],
      elevatorName: json['elevator_name'],
      buildingId: json['building_id'],
      buildingName: json['building_name'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at']),
      status: IssueStatusExtension.fromString(json['status']),
    );
  }

  IssueModel copyWith({
    String? issueId,
    String? reportId,
    String? elevatorId,
    String? buildingId,
    String? description,
    IssueType? issueType,
    IssueStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IssueModel(
      buildingName: buildingName,
      elevatorName: elevatorName,
      issueId: issueId ?? this.issueId,
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
      'issue_type': issueType,
      'building_name': buildingName,
      'elevator_name': elevatorName
    };
  }
}
