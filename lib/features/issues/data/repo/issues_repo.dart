import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:either_dart/either.dart';

abstract class IssuesRepo {
  IssuesRepo();

  Future<Either<Failure, void>> createIssue(IssueModel issueModel);

  Future<Either<Failure, List<ElevatorSummaryModel>?>> fetchElevators(
      String buildingId);

  Future<Either<Failure, List<IssueModel>?>> fetchActiveIssues();
}
