import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:either_dart/either.dart';

class IssuesRepoImp implements IssuesRepo {
  final ApiService _api;

  IssuesRepoImp(this._api);

  @override
  Future<Either<Failure, void>> create(IssueRequestModel issueModel) async =>
      await _api.createIssue(issueModel);

  @override
  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchActiveIssuesForBuilding(String buildingId) async =>
          await _api.fetchActiveIssuesForBuilding(buildingId);

  @override
  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchActiveIssuesForElevator(String elevatorId) async =>
          await _api.fetchActiveIssuesForElevator(elevatorId);

  @override
  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchAllActiveIssues() async => await _api.fetchAllActiveIssues();

  @override
  Future<Either<Failure, IssueResponseModel>> fetchIssueDetails(
          String issueId) async =>
      await _api.fetchIssueDetails(issueId);
}
