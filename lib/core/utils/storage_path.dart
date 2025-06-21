import 'package:UpDown/core/utils/localization/constants.dart';
import 'package:UpDown/features/issues/data/models/create_issue_model.dart';

class StoragePath {
  final String path;
  const StoragePath(this.path);

  factory StoragePath.fromIssue({required CreateIssueModel issue}) {
    final fileName = issue.media!.file!.path.split('/').last;
    final mediaTypeFolder = issue.media!.type.name;
    return StoragePath(
        "${issue.reportId}/${issue.id}/$mediaTypeFolder/$fileName");
  }
  factory StoragePath.fromAvatar(
      {required String filePath, required String userId}) {
    final fileName = filePath.split('/').last;
    final folder = kAvatarsBucketFolder;
    return StoragePath("$folder/$userId/$fileName");
  }
}
