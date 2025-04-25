import 'issue_model.dart';

class ReportModel {
  final String status;
  final String? reportId;
  final String buildingId;
  final String reportedBy;
  final List<IssueModel> issues;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ReportModel({
    required this.status,
    this.reportId,
    required this.reportedBy,
    this.issues = const [],
    required this.buildingId,
    this.createdAt,
    this.updatedAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        status: json['status'],
        reportId: json['report_id'],
        buildingId: json['building_id'],
        reportedBy: json['reported_by'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        issues: json['issues'] ?? [],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'reported_by': reportedBy,
        'building_id': buildingId,
      };
}
