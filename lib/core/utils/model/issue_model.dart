class IssueModel {
  final String issueId;
  final String? description;
  final String status;
  final String issueType;
  final String reportId;
  final DateTime createdAt;
  final DateTime updatedAt;

  IssueModel({
    required this.issueId,
    this.description,
    required this.issueType,
    required this.reportId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      issueId: json['issueID'],
      description: json['description'],
      issueType: json['issueType'],
      reportId: json['reportId'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issueID': issueId,
      'description': description,
      'issueType': issueType,
      'reportId': reportId,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
      'status': status
    };
  }
}
