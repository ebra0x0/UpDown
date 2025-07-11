import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/model/media_models/media_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_response_model.g.dart';

@JsonSerializable(createToJson: false)
class IssueResponseModel {
  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "user_id")
  final String userId;

  @JsonKey(name: "report_id")
  final String reportId;

  @JsonKey(name: "elevator_id")
  final String elevatorId;

  @JsonKey(name: "building_id")
  final String buildingId;

  @JsonKey(name: "building_name")
  final String buildingName;

  @JsonKey(name: "elevator_name")
  final String elevatorName;

  final String? description;

  @JsonKey(name: "issue_type")
  final IssueType issueType;

  final MediaResponseModel? media;

  final IssueStatus status;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  final IssuePriority priority;

  final int? cost;

  @JsonKey(name: "technician_note")
  final String? technicianNote;

  @JsonKey(name: "resolved_at")
  final DateTime? resolvedAt;

  const IssueResponseModel({
    required this.id,
    required this.userId,
    required this.reportId,
    required this.elevatorId,
    required this.buildingId,
    required this.buildingName,
    required this.elevatorName,
    this.description,
    required this.issueType,
    this.media,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    required this.priority,
    this.cost,
    this.technicianNote,
    this.resolvedAt,
  });

  factory IssueResponseModel.fromJson(Map<String, dynamic> json) =>
      _$IssueResponseModelFromJson(json);

  IssueResponseModel copyWith({
    String? id,
    String? userId,
    String? reportId,
    String? elevatorId,
    String? buildingId,
    String? buildingName,
    String? elevatorName,
    String? description,
    IssueType? issueType,
    MediaResponseModel? media,
    IssueStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    IssuePriority? priority,
    int? cost,
    String? technicianNote,
    DateTime? resolvedAt,
  }) {
    return IssueResponseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      reportId: reportId ?? this.reportId,
      elevatorId: elevatorId ?? this.elevatorId,
      buildingId: buildingId ?? this.buildingId,
      buildingName: buildingName ?? this.buildingName,
      elevatorName: elevatorName ?? this.elevatorName,
      description: description ?? this.description,
      issueType: issueType ?? this.issueType,
      media: media ?? this.media,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      priority: priority ?? this.priority,
      cost: cost ?? this.cost,
      technicianNote: technicianNote ?? this.technicianNote,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }

  static IssueResponseModel empty() => IssueResponseModel(
        id: '#123456',
        userId: '',
        reportId: '',
        elevatorId: '',
        buildingId: '',
        buildingName: 'اسم المبنى',
        elevatorName: 'اسم المصعد',
        description: 'وصف العطل',
        issueType: IssueType.other,
        media: null,
        status: IssueStatus.notFixed,
        createdAt: DateTime.now(),
        updatedAt: null,
        priority: IssuePriority.low,
        cost: null,
        technicianNote: 'ملاحظات الفني',
        resolvedAt: null,
      );
}
