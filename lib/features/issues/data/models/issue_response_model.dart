import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/model/media_models/media_response_model.dart';

part 'issue_response_model.freezed.dart';
part 'issue_response_model.g.dart';

@Freezed(toJson: false)
@HiveType(typeId: HiveTypeIds.issueModel)
class IssueResponseModel with _$IssueResponseModel {
  const factory IssueResponseModel({
    @HiveField(0) @JsonKey(name: "id") required String id,
    @HiveField(1) @JsonKey(name: "user_id") required String userId,
    @HiveField(2) @JsonKey(name: "report_id") required String reportId,
    @HiveField(3) @JsonKey(name: "elevator_id") required String elevatorId,
    @HiveField(4) @JsonKey(name: "building_id") required String buildingId,
    @HiveField(5) @JsonKey(name: "building_name") required String buildingName,
    @HiveField(6) @JsonKey(name: "elevator_name") required String elevatorName,
    @HiveField(7) String? description,
    @HiveField(8) @JsonKey(name: "issue_type") required IssueType issueType,
    @HiveField(9) @JsonKey(name: "media_urls") required List<String> mediaUrls,
    @HiveField(10)
    @JsonKey(name: "media_list")
    @Default([])
    List<MediaResponseModel> mediaList,
    @HiveField(11) required IssueStatus status,
    @HiveField(12) @JsonKey(name: "created_at") required DateTime createdAt,
    @HiveField(13) @JsonKey(name: "updated_at") DateTime? updatedAt,
    @HiveField(14) required IssuePriority priority,
    @HiveField(15) int? cost,
    @HiveField(16) @JsonKey(name: "technician_note") String? technicianNote,
    @HiveField(17) @JsonKey(name: "resolved_at") DateTime? resolvedAt,
  }) = _IssueResponseModel;

  factory IssueResponseModel.fromJson(Map<String, dynamic> json) =>
      _$IssueResponseModelFromJson(json);

  factory IssueResponseModel.empty() => IssueResponseModel(
        id: '#123456',
        userId: '',
        reportId: '',
        elevatorId: '',
        buildingId: '',
        buildingName: 'اسم المبنى',
        elevatorName: 'اسم المصعد',
        description: 'وصف العطل',
        issueType: IssueType.other,
        mediaUrls: [],
        mediaList: [],
        status: IssueStatus.notFixed,
        createdAt: DateTime.now(),
        updatedAt: null,
        priority: IssuePriority.low,
        cost: null,
        technicianNote: 'ملاحظات الفني',
        resolvedAt: null,
      );
}
