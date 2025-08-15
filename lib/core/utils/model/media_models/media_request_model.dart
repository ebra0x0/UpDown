import 'dart:io';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_request_model.g.dart';

@JsonSerializable(createFactory: false)
class MediaRequestModel {
  final MediaType type;
  @JsonKey(includeToJson: false)
  final File? file;
  final String url;
  @JsonKey(name: "issue_id")
  final String? issueId;

  MediaRequestModel(
      {required this.url, required this.type, this.issueId, this.file});

  Map<String, dynamic> toJson() => _$MediaRequestModelToJson(this);

  MediaRequestModel copyWith(
          {MediaType? type,
          File? file,
          String? url,
          String? issueId,
          DateTime? createdAt}) =>
      MediaRequestModel(
          type: type ?? this.type,
          file: file ?? this.file,
          url: url ?? this.url,
          issueId: issueId ?? this.issueId);
}
