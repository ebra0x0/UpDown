class BuildingSummary {
  final String buildingId;
  final String name;
  final int elevatorCount;
  final bool hasActiveReport;

  BuildingSummary({
    required this.buildingId,
    required this.name,
    required this.elevatorCount,
    required this.hasActiveReport,
  });

  factory BuildingSummary.fromJson(Map<String, dynamic> json) {
    return BuildingSummary(
      buildingId: json['building_id'],
      name: json['building_name'],
      elevatorCount: json['elevator_count'],
      hasActiveReport: json['active_report'],
    );
  }
}
