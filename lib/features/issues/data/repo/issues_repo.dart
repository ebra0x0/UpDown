import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/core/network/api_service.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:either_dart/either.dart';

class IssuesRepo {
  final ApiService _api;

  IssuesRepo(this._api);

  Future<Either<Failure, void>> create(IssueRequestModel issueModel) async {
    try {
      final res = await _api.createIssue(issueModel);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchActiveIssuesForBuilding(String buildingId) async {
    try {
      final res = await _api.fetchActiveIssuesForBuilding(buildingId);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchActiveIssuesForElevator(String elevatorId) async {
    try {
      final res = await _api.fetchActiveIssuesForElevator(elevatorId);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchAllActiveIssues() async {
    try {
      final res = await _api.fetchAllActiveIssues();
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }

  Future<Either<Failure, IssueResponseModel>> fetchIssueDetails(
      String issueId) async {
    try {
      final res = await _api.fetchIssueDetails(issueId);
      return Right(res);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CustomFailure((e as Failure).errMessage));
    }
  }
}
