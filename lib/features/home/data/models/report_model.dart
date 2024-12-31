class ReportModel {
  const ReportModel({
    required this.status,
    required this.id,
    required this.reporterName,
    required this.reporterPhone,
    required this.buildingName,
    this.elevatorNumber,
    this.floorNumber,
    required this.issueType,
    this.description,
    required this.reportDate,
    required this.location,
    this.images,
    this.video,
    required this.technicianName,
    this.technicianPhone,
    this.technicianComment,
  });
  final String status;
  final String id;
  final String reporterName;
  final String reporterPhone;
  final String buildingName;
  final int? elevatorNumber;
  final int? floorNumber;
  final String issueType;
  final String? description;
  final String reportDate;
  final Map<double, double> location;
  final List? images;
  final String? video;
  final String technicianName;
  final String? technicianPhone;
  final String? technicianComment;
}
