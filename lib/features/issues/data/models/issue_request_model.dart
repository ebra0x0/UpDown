import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/models/media_models/media_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_request_model.g.dart';

@JsonSerializable(createFactory: false)
class IssueRequestModel {
  @JsonKey(includeToJson: false)
  final String? id;
  @JsonKey(name: 'report_id', includeToJson: false)
  final String? reportId;
  @JsonKey(name: 'issue_type')
  final IssueType issueType;
  final String? description;
  final IssuePriority priority;
  @JsonKey(name: 'media_urls')
  final List<String> mediaUrls;
  @JsonKey(includeToJson: false)
  final List<MediaRequestModel> mediaList;
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
    this.mediaUrls = const [],
    this.mediaList = const [],
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
    List<String>? mediaUrls,
    List<MediaRequestModel>? mediaList,
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
      mediaUrls: mediaUrls ?? this.mediaUrls,
      mediaList: mediaList ?? this.mediaList,
      buildingId: buildingId ?? this.buildingId,
      elevatorId: elevatorId ?? this.elevatorId,
      buildingName: buildingName ?? this.buildingName,
      elevatorName: elevatorName ?? this.elevatorName,
    );
  }
}
