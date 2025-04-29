class BuildingSummaryModel {
  final String id;
  final String name;
  final int elevatorsCount;
  final bool hasActiveReport;

  BuildingSummaryModel({
    required this.id,
    required this.name,
    required this.elevatorsCount,
    required this.hasActiveReport,
  });

  factory BuildingSummaryModel.fromJson(Map<String, dynamic> json) {
    return BuildingSummaryModel(
      id: json['building_id'],
      name: json['building_name'],
      elevatorsCount: json['elevators_count'],
      hasActiveReport: json['has_active_report'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'building_id': id,
      'name': name,
      'elevator_count': elevatorsCount,
      'active_report': hasActiveReport,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BuildingSummaryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
