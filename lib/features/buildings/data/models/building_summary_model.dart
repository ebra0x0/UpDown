class BuildingSummaryModel {
  final String id;
  final String name;
  final String ownerId;
  final int elevatorsCount;
  final bool hasActiveReport;

  const BuildingSummaryModel({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.elevatorsCount,
    required this.hasActiveReport,
  });

  factory BuildingSummaryModel.fromJson(Map<String, dynamic> json) {
    return BuildingSummaryModel(
      id: json['id'],
      ownerId: json['owner_id'],
      name: json['name'],
      elevatorsCount: json['elevators_count'],
      hasActiveReport: json['has_active_report'],
    );
  }

  factory BuildingSummaryModel.empty() => const BuildingSummaryModel(
        id: "",
        ownerId: "",
        name: "",
        elevatorsCount: 0,
        hasActiveReport: false,
      );

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
