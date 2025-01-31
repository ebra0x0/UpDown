import 'issue_model.dart';

class ReportModel {
  final String status;
  final String reportId;
  final String buildingId;
  final String reportedBy;
  final String? description;
  final List<IssueModel> issues;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReportModel({
    required this.status,
    required this.reportId,
    required this.reportedBy,
    this.description,
    required this.issues,
    required this.buildingId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        status: json['status'],
        reportId: json['report_id'],
        buildingId: json['building_id'],
        reportedBy: json['reported_by'],
        description: json['description'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        issues: json['issues'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'report_id': reportId,
        'reporter_by': reportedBy,
        'description': description,
        'building_id': buildingId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
