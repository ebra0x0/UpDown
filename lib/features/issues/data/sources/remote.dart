import 'package:UpDown/core/network/api/api_service.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';

class IssuesRemoteDataSource {
  final ApiService _api;

  IssuesRemoteDataSource(this._api);

  Future<void> createIssue(IssueRequestModel issueModel) async =>
      await _api.createIssue(issueModel);

  Stream<List<IssueResponseModel>> fetchAllActiveIssues() {
    return _api.streamAllActiveIssues().map((json) {
      if (json.isEmpty) return [];
      return json.map((map) => IssueResponseModel.fromJson(map)).toList();
    });
  }

  Stream<List<IssueResponseModel>> fetchBuildingActiveIssues(
      String buildingId) {
    return _api.streamBuildingActiveIssues(buildingId).map((json) {
      if (json.isEmpty) return [];
      return json.map((map) => IssueResponseModel.fromJson(map)).toList();
    });
  }

  Stream<List<IssueResponseModel>> fetchElevatorActiveIssues(
      String elevatorId) {
    return _api.streamElevatorActiveIssues(elevatorId).map((json) {
      if (json.isEmpty) return [];
      return json.map((map) => IssueResponseModel.fromJson(map)).toList();
    });
  }

  Stream<IssueResponseModel?> fetchIssueDetails(String issueId) {
    return _api.fetchIssueDetails(issueId).map((json) {
      if (json == null) return null;
      return IssueResponseModel.fromJson(json);
    });
  }
}
