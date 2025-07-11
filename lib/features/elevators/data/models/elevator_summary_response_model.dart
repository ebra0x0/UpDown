import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'elevator_summary_response_model.g.dart';

@JsonSerializable(createToJson: false)
class ElevatorSummaryResponseModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'building_id')
  final String buildingId;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'building_name')
  final String buildingName;

  @JsonKey(
    name: 'status',
  )
  final ElevatorStatus status;

  @JsonKey(
    name: 'active_issue',
  )
  final ActiveIssue? activeIssue;

  const ElevatorSummaryResponseModel({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.buildingName,
    required this.status,
    this.activeIssue,
  });

  factory ElevatorSummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ElevatorSummaryResponseModelFromJson(json);

  factory ElevatorSummaryResponseModel.empty() =>
      const ElevatorSummaryResponseModel(
        id: "",
        buildingId: "",
        name: "اسم المصعد",
        buildingName: "اسم المبنى",
        status: ElevatorStatus.working,
        activeIssue: null,
      );
}

@JsonSerializable(createToJson: false)
class ActiveIssue {
  @JsonKey(name: 'issue_type')
  final IssueType issueType;

  @JsonKey(name: 'issue_date')
  final DateTime issueDate;

  const ActiveIssue({
    required this.issueType,
    required this.issueDate,
  });

  factory ActiveIssue.fromJson(Map<String, dynamic> json) =>
      _$ActiveIssueFromJson(json);
}
