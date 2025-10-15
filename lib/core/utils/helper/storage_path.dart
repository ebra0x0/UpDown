import 'package:UpDown/core/network/api/api_constants.dart';
import 'package:UpDown/core/utils/models/media_models/media_request_model.dart';
import 'dart:io';
import 'package:crypto/crypto.dart';

class StoragePath {
  final String path;
  const StoragePath(this.path);

  static Future<StoragePath> withIssue({
    required MediaRequestModel media,
    required String reportId,
    required String issueId,
  }) async {
    final hash = await _generateImageHash(media.file!);
    final mediaTypeFolder = media.type.name;
    return StoragePath("$reportId/$issueId/$mediaTypeFolder/$hash");
  }

  static Future<StoragePath> fromAvatar({
    required String filePath,
    required String userId,
  }) async {
    final hash = await _generateImageHash(File(filePath));
    final folder = ApiConstants.avatarsBucketFolder;
    return StoragePath("$folder/$userId/$hash");
  }

  static Future<String> _generateImageHash(File file) async {
    final bytes = await file.readAsBytes();
    final hash = md5.convert(bytes);
    return hash.toString();
  }
}
