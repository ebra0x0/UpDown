class BuildingSummaryModel {
  final String buildingId;
  final String name;
  final int elevatorsCount;
  final bool hasActiveReport;

  BuildingSummaryModel({
    required this.buildingId,
    required this.name,
    required this.elevatorsCount,
    required this.hasActiveReport,
  });

  factory BuildingSummaryModel.fromJson(Map<String, dynamic> json) {
    return BuildingSummaryModel(
      buildingId: json['building_id'],
      name: json['building_name'],
      elevatorsCount: json['elevators_count'],
      hasActiveReport: json['has_active_report'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'building_id': buildingId,
      'name': name,
      'elevator_count': elevatorsCount,
      'active_report': hasActiveReport,
    };
  }
}
