class ElevatorSummaryModel {
  final String elevatorId;
  final String status;
  final int elevatorNumber;
  final String? issueType;
  final DateTime? nextMaintenanceDate;

  ElevatorSummaryModel({
    required this.elevatorId,
    required this.elevatorNumber,
    required this.issueType,
    required this.status,
    this.nextMaintenanceDate,
  });

  factory ElevatorSummaryModel.fromJson(Map<String, dynamic> json) {
    return ElevatorSummaryModel(
      issueType: json["active_issue"]["issue_type"],
      elevatorId: json["elevator_id"],
      elevatorNumber: json["elevator_number"],
      nextMaintenanceDate: json["next_maintenance_date"] == null
          ? null
          : DateTime.parse(json["next_maintenance_date"]),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'elevator_id': elevatorId,
        'elevator_number': elevatorNumber,
        'issue_type': issueType,
        'status': status,
        'next_maintenance_date': nextMaintenanceDate?.toIso8601String(),
      };
}
