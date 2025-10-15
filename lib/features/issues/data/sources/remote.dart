import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';

class IssuesRemoteDataSource {
  final ApiService _api;

  IssuesRemoteDataSource(this._api);

  Future<void> createIssue(IssueRequestModel issueModel) async =>
      await _api.createIssue(issueModel);

  Stream<List<IssueResponseModel>> streamAllActiveIssues() {
    return _api.streamAllActiveIssues().map((json) {
      if (json.isEmpty) return [];
      return json.map((map) => IssueResponseModel.fromJson(map)).toList();
    });
  }

  Future<List<IssueResponseModel>> fetchIssues(
      {int offset = 0, int limit = 5}) async {
    final json = await _api.fetchIssues();
    return json.map((map) => IssueResponseModel.fromJson(map)).toList();
  }

  Future<List<IssueResponseModel>> fetchBuildingIssues(
      {required String buildingId, int offset = 0, int limit = 5}) async {
    final json = await _api.fetchBuildingIssues(
        buildingId: buildingId, offset: offset, limit: limit);
    return json.map((map) => IssueResponseModel.fromJson(map)).toList();
  }

  Future<List<IssueResponseModel>> fetchElevatorIssues(
      {required String elevatorId, int offset = 0, int limit = 5}) async {
    final json = await _api.fetchElevatorIssues(
        elevatorId: elevatorId, offset: offset, limit: limit);
    return json.map((map) => IssueResponseModel.fromJson(map)).toList();
  }

  Future<IssueResponseModel?> fetchIssueDetails(String issueId) async {
    final json = await _api.fetchIssueDetails(issueId);
    if (json == null) return null;
    return IssueResponseModel.fromJson(json);
  }
}
