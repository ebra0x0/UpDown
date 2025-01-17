import 'package:UpDown/core/utils/model/issue_model.dart';

class ReportModel {
  final String status;
  final String reportId;
  final String reportedBy;
  final String elevatorId;
  final String? description;
  final List<IssueModel> issue;
  final List<String>? images;
  final String? video;
  final DateTime createdAt;
  final String updatedAt;

  const ReportModel({
    required this.status,
    required this.reportId,
    required this.reportedBy,
    required this.elevatorId,
    this.description,
    required this.issue,
    this.images,
    this.video,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        status: json['status'],
        reportId: json['report_id'],
        reportedBy: json['reporter_by'],
        elevatorId: json['elevator_id'],
        description: json['description'],
        issue: [],
        images:
            json['images'] != null ? List<String>.from(json['images']) : null,
        video: json['video'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'report_id': reportId,
        'reporter_by': reportedBy,
        'elevator_id': elevatorId,
        'description': description,
        'images': images,
        'video': video,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt,
      };
}
