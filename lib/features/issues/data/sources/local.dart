import 'package:UpDown/core/storage/hive/hive_constants.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class IssuesLocalDataSource {
  static const _boxName = HiveConstants.issuesBox;

  Future<LazyBox<IssueResponseModel>> _getBox() async {
    try {
      if (!Hive.isBoxOpen(_boxName)) {
        return await Hive.openLazyBox<IssueResponseModel>(_boxName);
      }
      return Hive.lazyBox<IssueResponseModel>(_boxName);
    } catch (e) {
      throw ('Failed to open issues box: $e');
    }
  }

  Future<IssueResponseModel?> get(String issueId) async {
    try {
      final box = await _getBox();
      return await box.get(issueId);
    } catch (e) {
      throw ('Failed to get issue $issueId: $e');
    }
  }

  Future<List<IssueResponseModel>> _getFilteredIssues({
    bool Function(IssueResponseModel)? filter,
  }) async {
    try {
      final box = await _getBox();
      final keys = box.keys.cast<String>();

      final issues = await Future.wait(
        keys.map((key) async => await box.get(key)),
      );

      final validIssues = issues.whereType<IssueResponseModel>();
      return filter != null
          ? validIssues.where(filter).toList()
          : validIssues.toList();
    } catch (e) {
      throw ('Failed to get issues: $e');
    }
  }

  Future<List<IssueResponseModel>> getAll() async {
    return _getFilteredIssues();
  }

  Future<List<IssueResponseModel>> getIssuesForBuilding(
      String buildingId) async {
    return _getFilteredIssues(
      filter: (issue) => issue.buildingId == buildingId,
    );
  }

  Future<List<IssueResponseModel>> getIssuesForElevator(
      String elevatorId) async {
    return _getFilteredIssues(
      filter: (issue) => issue.elevatorId == elevatorId,
    );
  }

  Future<void> save(IssueResponseModel issue) async {
    try {
      final box = await _getBox();
      await box.put(issue.id, issue);
    } catch (e) {
      throw ('Failed to save issue ${issue.id}: $e');
    }
  }

  Future<void> saveAll(List<IssueResponseModel> issues) async {
    try {
      final box = await _getBox();
      await Future.wait(
        issues.map((issue) => box.put(issue.id, issue)),
      );
    } catch (e) {
      throw ('Failed to save issues: $e');
    }
  }

  Future<void> delete(String issueId) async {
    try {
      final box = await _getBox();
      await box.delete(issueId);
    } catch (e) {
      throw ('Failed to delete issue $issueId: $e');
    }
  }

  Future<void> clear() async {
    try {
      final box = await _getBox();
      await box.clear();
    } catch (e) {
      throw ('Failed to clear issues: $e');
    }
  }

  Future<void> closeBox() async {
    try {
      if (Hive.isBoxOpen(_boxName)) {
        final box = Hive.lazyBox<IssueResponseModel>(_boxName);
        await box.close();
      }
    } catch (e) {
      throw ('Failed to close profile box: $e');
    }
  }
}
