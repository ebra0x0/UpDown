class BuildingSummary {
  final String buildingId;
  final String name;
  final int elevatorCount;
  final int reportsCount;

  BuildingSummary({
    required this.buildingId,
    required this.name,
    required this.elevatorCount,
    required this.reportsCount,
  });

  factory BuildingSummary.fromJson(Map<String, dynamic> json) {
    return BuildingSummary(
      buildingId: json['building_id'],
      name: json['building_name'],
      elevatorCount: json['elevator_count'],
      reportsCount: json['reports_count'] ?? 0,
    );
  }
}
