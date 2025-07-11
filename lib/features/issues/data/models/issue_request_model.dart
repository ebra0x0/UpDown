import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/model/media_models/media_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_request_model.g.dart';

@JsonSerializable(createFactory: false)
class IssueRequestModel {
  final String? id;
  @JsonKey(name: 'report_id')
  final String? reportId;
  @JsonKey(name: 'issue_type')
  final IssueType issueType;
  final String? description;
  final IssuePriority priority;
  final MediaRequestModel? media;
  @JsonKey(name: 'building_id')
  final String buildingId;
  @JsonKey(name: 'elevator_id')
  final String elevatorId;
  @JsonKey(name: 'building_name')
  final String buildingName;
  @JsonKey(name: 'elevator_name')
  final String elevatorName;

  const IssueRequestModel({
    this.id,
    this.reportId,
    required this.issueType,
    this.description,
    required this.priority,
    this.media,
    required this.buildingId,
    required this.elevatorId,
    required this.buildingName,
    required this.elevatorName,
  });

  Map<String, dynamic> toJson() => _$IssueRequestModelToJson(this);

  IssueRequestModel copyWith({
    String? id,
    String? reportId,
    IssueType? issueType,
    String? description,
    IssuePriority? priority,
    MediaRequestModel? media,
    String? buildingId,
    String? elevatorId,
    String? buildingName,
    String? elevatorName,
  }) {
    return IssueRequestModel(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      issueType: issueType ?? this.issueType,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      media: media ?? this.media,
      buildingId: buildingId ?? this.buildingId,
      elevatorId: elevatorId ?? this.elevatorId,
      buildingName: buildingName ?? this.buildingName,
      elevatorName: elevatorName ?? this.elevatorName,
    );
  }
}
