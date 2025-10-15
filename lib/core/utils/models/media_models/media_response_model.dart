import 'package:UpDown/core/storage/hive/hive_type_ids.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_response_model.g.dart';

@HiveType(typeId: HiveTypeIds.mediaModel)
@JsonSerializable(createToJson: false)
class MediaResponseModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  @JsonKey(name: "issue_id")
  final String issueId;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final MediaType type;

  @HiveField(4)
  @JsonKey(name: "created_at")
  final DateTime createdAt;

  MediaResponseModel({
    required this.id,
    required this.issueId,
    required this.type,
    required this.url,
    required this.createdAt,
  });

  factory MediaResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MediaResponseModelFromJson(json);

  MediaResponseModel copyWith({
    String? id,
    String? issueId,
    String? url,
    MediaType? type,
    DateTime? createdAt,
  }) {
    return MediaResponseModel(
      id: id ?? this.id,
      issueId: issueId ?? this.issueId,
      url: url ?? this.url,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
