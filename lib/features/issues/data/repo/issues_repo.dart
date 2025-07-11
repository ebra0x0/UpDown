import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/issues/data/models/issue_request_model.dart';
import 'package:UpDown/features/issues/data/models/issue_response_model.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:either_dart/either.dart';

abstract class IssuesRepo {
  Future<Either<Failure, void>> create(IssueRequestModel issueModel);

  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchAllActiveIssues();

  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchActiveIssuesForBuilding(String buildingId);

  Future<Either<Failure, List<IssueSummaryResponseModel>?>>
      fetchActiveIssuesForElevator(String elevatorId);

  Future<Either<Failure, IssueResponseModel>> fetchIssueDetails(String issueId);
}
