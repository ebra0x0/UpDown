import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/issues/data/models/create_issue_model.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_model.dart';
import 'package:either_dart/either.dart';

abstract class IssuesRepo {
  Future<Either<Failure, void>> create(CreateIssueModel issueModel);

  Future<Either<Failure, List<IssueSummaryModel>?>> fetchAllActiveIssues();

  Future<Either<Failure, List<IssueSummaryModel>?>>
      fetchActiveIssuesForBuilding(String buildingId);

  Future<Either<Failure, List<IssueSummaryModel>?>>
      fetchActiveIssuesForElevator(String elevatorId);
}
