import 'package:UpDown/constants.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/data/models/media_model.dart';

String buildStorageIssuePath(
    IssueModel issue, MediaModel media, String issueId) {
  final fileName = media.file!.path.split('/').last;
  final folder = kIssuesBucketFolders[media.type.name]!;
  return "${issue.buildingId}/${issue.elevatorId}/$issueId/$folder/$fileName";
}
