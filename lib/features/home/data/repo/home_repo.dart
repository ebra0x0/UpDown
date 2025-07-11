import 'package:UpDown/core/network/api_failure.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
import 'package:either_dart/either.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BuildingSummaryModel>?>> fetchBuildings();

  Future<Either<Failure, List<IssueSummaryResponseModel>?>> fetchActiveIssues();
}
