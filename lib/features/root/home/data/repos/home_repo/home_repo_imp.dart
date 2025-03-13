import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/root/create_issue/data/model/issue_model.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/repos/home_repo/home_repo.dart';
import 'package:either_dart/either.dart';

class HomeRepoImp implements HomeRepo {
  HomeRepoImp(this.apiService);
  final ApiService apiService;

  @override
  List<BuildingSummaryModel> buildingsCash = [];
  @override
  List<IssueModel> issuesCash = [];

  @override
  Future<Either<Failure, List<BuildingSummaryModel>>>
      fetchBuildingsSummary() async {
    if (buildingsCash.isNotEmpty) {
      return Right(buildingsCash);
    }
    final result = await apiService.fetchBuildingsSummary();
    result.fold(
      (errMsg) => errMsg,
      (response) => response,
    );

    if (result.isLeft) {
      return Left(result.left);
    }
    buildingsCash = result.right;
    return Right(result.right);
  }

  @override
  Future<Either<Failure, List<IssueModel>>> fetchActiveIssues() async {
    if (issuesCash.isNotEmpty) {
      return Right(issuesCash);
    }
    final result = await apiService.fetchActiveIssues();
    result.fold(
      (errMsg) => errMsg,
      (response) => response,
    );

    if (result.isLeft) {
      return Left(result.left);
    }
    issuesCash = result.right;
    return Right(result.right);
  }
}
