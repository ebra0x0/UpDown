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
      issueType: json["issue_type"],
      elevatorId: json["elevator_id"],
      elevatorNumber: json["elevator_number"],
      nextMaintenanceDate: json["next_maintenance_date"] == null
          ? null
          : DateTime.parse(json["next_maintenance_date"]),
      status: json["status"],
    );
  }
}
