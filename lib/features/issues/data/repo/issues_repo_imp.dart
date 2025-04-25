import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo.dart';
import 'package:either_dart/either.dart';

class IssuesRepoImp implements IssuesRepo {
  final ApiService _api;

  IssuesRepoImp(this._api);

  @override
  Future<Either<Failure, void>> createIssue(IssueModel issueModel) async {
    final result = await _api.createIssue(issueModel);

    return result.fold(
      (errMsg) => Left(errMsg),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, List<IssueModel>?>> fetchActiveIssues() async {
    final result = await _api.fetchActiveIssues();
    return result.fold(
      (errMsg) => Left(errMsg),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, List<ElevatorSummaryModel>?>> fetchElevators(
      String buildingId) {
    final res = _api.fetchElevators(buildingId: buildingId);
    return res.fold(
      (failure) => Left(failure),
      (elevators) => Right(elevators),
    );
  }
}
