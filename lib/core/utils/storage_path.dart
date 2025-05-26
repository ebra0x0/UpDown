import 'package:UpDown/core/utils/constants.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/data/models/media_model.dart';

class StoragePath {
  final String path;
  const StoragePath(this.path);

  factory StoragePath.fromIssue(
      {required IssueModel issue, required MediaModel media}) {
    final fileName = media.file!.path.split('/').last;
    final folder = kIssuesBucketFolders[media.type.name]!;
    return StoragePath(
        "${issue.buildingId}/${issue.elevatorId}/${media.issueId}/$folder/$fileName");
  }
  factory StoragePath.fromAvatar(
      {required String filePath, required String userId}) {
    final fileName = filePath.split('/').last;
    final folder = kAvatarsBucketFolder;
    return StoragePath("$folder/$userId/$fileName");
  }
}
