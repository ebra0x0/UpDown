import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/issues/data/models/issue_model.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/home/data/repo/home_repo.dart';
import 'package:either_dart/either.dart';

class HomeRepoImp implements HomeRepo {
  HomeRepoImp(this._api);
  final ApiService _api;

  @override
  Future<Either<Failure, List<BuildingSummaryModel>?>> fetchBuildings() async {
    final result = await _api.fetchBuildings();
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
}
