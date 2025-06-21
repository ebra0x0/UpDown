import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/issues/data/models/create_issue_model.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:either_dart/either.dart';

class IssuesRepoImp implements IssuesRepo {
  final ApiService _api;

  IssuesRepoImp(this._api);

  @override
  Future<Either<Failure, void>> create(CreateIssueModel issueModel) async {
    return await _api.createIssue(issueModel);
  }

  @override
  Future<Either<Failure, List<IssueSummaryModel>?>>
      fetchActiveIssuesForBuilding(String buildingId) async {
    return await _api.fetchActiveIssuesForBuilding(buildingId);
  }

  @override
  Future<Either<Failure, List<IssueSummaryModel>?>>
      fetchActiveIssuesForElevator(String elevatorId) async {
    return await _api.fetchActiveIssuesForElevator(elevatorId);
  }

  @override
  Future<Either<Failure, List<IssueSummaryModel>?>> fetchAllActiveIssues() {
    return _api.fetchAllActiveIssues();
  }
}
