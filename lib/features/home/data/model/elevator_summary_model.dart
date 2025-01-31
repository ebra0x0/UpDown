class ElevatorSummaryModel {
  final String elevatorId;
  final String status;
  final int elevatorNumber;
  final DateTime? nextMaintenanceDate;

  ElevatorSummaryModel({
    required this.elevatorId,
    required this.elevatorNumber,
    this.nextMaintenanceDate,
    required this.status,
  });

  factory ElevatorSummaryModel.fromJson(Map<String, dynamic> json) {
    return ElevatorSummaryModel(
      elevatorId: json["elevator_id"],
      elevatorNumber: json["elevator_number"],
      nextMaintenanceDate: json["next_maintenance_date"] == null
          ? null
          : DateTime.parse(json["next_maintenance_date"]),
      status: json["status"],
    );
  }
}
