import 'package:UpDown/core/network/api/api_constants.dart';
import 'package:UpDown/core/utils/model/media_models/media_request_model.dart';

class StoragePath {
  final String path;
  const StoragePath(this.path);

  factory StoragePath.withIssue(
      {required MediaRequestModel media, required String reportId, issueId}) {
    final fileName = media.file?.path.split('/').last;
    final mediaTypeFolder = media.type.name;
    return StoragePath("$reportId/$issueId/$mediaTypeFolder/$fileName");
  }
  factory StoragePath.fromAvatar(
      {required String filePath, required String userId}) {
    final fileName = filePath.split('/').last;
    final folder = ApiConstants.avatarsBucketFolder;
    return StoragePath("$folder/$userId/$fileName");
  }
}
