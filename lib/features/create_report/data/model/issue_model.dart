class IssueModel {
  final String issueId;
  final String reportId;
  final String elevatorId;
  final String? description;
  final String status;
  final String issueType;
  final DateTime createdAt;
  final DateTime updatedAt;

  IssueModel({
    required this.issueId,
    required this.reportId,
    required this.elevatorId,
    this.description,
    required this.issueType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      issueId: json['issueID'],
      reportId: json['reportId'],
      elevatorId: json['elevatorId'],
      description: json['description'],
      issueType: json['issueType'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issueID': issueId,
      'reportId': reportId,
      'elevatorId': elevatorId,
      'description': description,
      'issueType': issueType,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
      'status': status
    };
  }
}
