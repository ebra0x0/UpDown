import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/core/utils/helper/sort_list.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IssuesLocalDataSource {
  static const _boxName = HiveConstants.issuesBox;

  Future<LazyBox> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openLazyBox(_boxName);
    }
    return Hive.lazyBox(_boxName);
  }

  Future<IssueResponseModel?> get(String issueId) async {
    final box = await _getBox();
    final issues = await _getAllIssues(box);
    return issues[issueId];
  }

  Future<List<IssueResponseModel>> getList(
      {int offset = 0, int limit = 5}) async {
    final box = await _getBox();
    final issues = await _getAllIssues(box);

    final sortedIssues =
        sortList(issues.values.toList(), (issue) => issue.createdAt);

    final paginated = sortedIssues.skip(offset).take(limit).toList();

    return paginated;
  }

  Future<List<IssueResponseModel>> getBuildingIssues({
    required String buildingId,
    int offset = 0,
    int limit = 5,
  }) async {
    final box = await _getBox();
    final issues = await _getAllIssues(box);

    final filteredIssues =
        issues.values.where((issue) => issue.buildingId == buildingId).toList();

    final sortedIssues = sortList(filteredIssues, (issue) => issue.createdAt);

    final paginated = sortedIssues.skip(offset).take(limit).toList();

    return paginated;
  }

  Future<List<IssueResponseModel>> getElevatorIssues(
      {required String elevatorId, int offset = 0, int limit = 5}) async {
    final issues = await getList();
    final filteredIssues =
        issues.where((issue) => issue.elevatorId == elevatorId).toList();

    final sortedIssues = sortList(filteredIssues, (issue) => issue.createdAt);

    final paginated = sortedIssues.skip(offset).take(limit).toList();

    return paginated;
  }

  Future<void> save(IssueResponseModel issue) async {
    final box = await _getBox();
    final issues = await _getAllIssues(box);

    issues[issue.id] = issue;
    await box.put(HiveConstants.issuesKey, issues);
  }

  Future<void> saveAll(List<IssueResponseModel> issuesList) async {
    final box = await _getBox();
    final issues = {for (final i in issuesList) i.id: i};

    await Future.wait([
      box.put(HiveConstants.issuesKey, issues),
      box.put(HiveConstants.lastSyncKey, DateTime.now().toIso8601String()),
    ]);
  }

  Future<void> delete(String issueId) async {
    final box = await _getBox();
    final issues = await _getAllIssues(box);

    if (issues.containsKey(issueId)) {
      issues.remove(issueId);
      await box.put(HiveConstants.issuesKey, issues);
    }
  }

  Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
  }

  Future<void> close() async {
    if (Hive.isBoxOpen(_boxName)) {
      final box = Hive.lazyBox(_boxName);
      await box.close();
    }
  }

  /// Helper function
  Future<Map<String, IssueResponseModel>> _getAllIssues(LazyBox box) async {
    final data = await box.get(HiveConstants.issuesKey) as Map?;
    return (data ?? {}).cast<String, IssueResponseModel>();
  }
}
