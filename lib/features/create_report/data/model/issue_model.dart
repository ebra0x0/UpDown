class IssueModel {
  final String issueId;
  final String reportId;
  final String elevatorId;
  final String description;
  final String status;
  final String issueType;
  final DateTime createdAt;
  final DateTime updatedAt;

  IssueModel({
    required this.issueId,
    required this.reportId,
    required this.elevatorId,
    required this.description,
    required this.issueType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      issueId: json['issue_id'],
      reportId: json['report_id'],
      elevatorId: json['elevator_id'],
      description: json['description'],
      issueType: json['issue_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issue_id': issueId,
      'report_id': reportId,
      'elevator_id': elevatorId,
      'description': description,
      'issue_type': issueType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
