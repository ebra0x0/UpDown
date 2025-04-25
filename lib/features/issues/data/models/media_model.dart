import 'dart:io';

import 'package:UpDown/core/utils/enums/enums.dart';

class MediaModel {
  final String? id;
  final String? issueId;
  final String url;
  final File? file;
  final MediaType type;
  final DateTime? createdAt;

  MediaModel({
    this.id,
    this.issueId,
    required this.type,
    required this.url,
    required this.file,
    this.createdAt,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'],
      type: json['type'],
      issueId: json['issue_id'],
      url: json['url'],
      file: json['file'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at']),
    );
  }

  MediaModel copyWith({
    String? id,
    String? issueId,
    String? url,
    File? file,
    MediaType? type,
    DateTime? createdAt,
  }) {
    return MediaModel(
      id: id ?? this.id,
      issueId: issueId ?? this.issueId,
      url: url ?? this.url,
      file: file ?? this.file,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issue_id': issueId,
      'type': type.name,
      'url': url,
    };
  }
}
