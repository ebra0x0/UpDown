import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_response_model.g.dart';

@JsonSerializable(createToJson: false)
class MediaResponseModel {
  final String id;
  @JsonKey(name: "issue_id")
  final String issueId;
  final String url;
  final MediaType type;
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
