import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:either_dart/either.dart';

abstract class HomeRepo {
  List<BuildingSummaryModel>? buildingsCash;
  Future<Either<Failure, List<BuildingSummaryModel>>> fetchBuildingsSummary();
  Future<Either<Failure, List<IssueModel>>> fetchActiveIssues();
}
