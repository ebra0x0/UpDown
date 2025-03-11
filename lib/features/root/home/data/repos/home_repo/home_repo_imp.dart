import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:UpDown/features/root/home/data/repos/home_repo/home_repo.dart';
import 'package:either_dart/either.dart';

class HomeRepoImp implements HomeRepo {
  HomeRepoImp(this.apiService);
  final ApiService apiService;

  @override
  List<BuildingSummaryModel>? cash;

  @override
  Future<Either<Failure, List<BuildingSummaryModel>>>
      fetchBuildingsSummary() async {
    if (cash != null) {
      return Right(cash!);
    }
    final result = await apiService.fetchBuildingsSummary();
    result.fold(
      (errMsg) => errMsg,
      (response) => response,
    );

    if (result.isLeft) {
      return Left(result.left);
    }
    cash = result.right;
    return Right(result.right);
  }
}
