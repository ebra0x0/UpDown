import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issue_summary_response_model.g.dart';

@JsonSerializable(createToJson: false)
class IssueSummaryResponseModel {
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'building_id')
  final String buildingId;

  @JsonKey(name: 'elevator_id')
  final String elevatorId;

  @JsonKey(name: 'building_name')
  final String buildingName;

  @JsonKey(name: 'elevator_name')
  final String elevatorName;

  @JsonKey(name: 'issue_type')
  final IssueType issueType;

  final IssueStatus status;

  final IssuePriority priority;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const IssueSummaryResponseModel({
    required this.id,
    required this.userId,
    required this.buildingId,
    required this.elevatorId,
    required this.buildingName,
    required this.elevatorName,
    required this.issueType,
    required this.status,
    required this.priority,
    required this.createdAt,
    this.updatedAt,
  });

  factory IssueSummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$IssueSummaryResponseModelFromJson(json);

  factory IssueSummaryResponseModel.empty() => IssueSummaryResponseModel(
        id: '#1234567',
        userId: '',
        buildingId: '',
        elevatorId: '',
        buildingName: 'اسم المبنى',
        elevatorName: 'اسم المصعد',
        issueType: IssueType.other,
        status: IssueStatus.notFixed,
        priority: IssuePriority.low,
        createdAt: DateTime.now(),
        updatedAt: null,
      );
}
