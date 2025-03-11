import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/root/home/data/model/building_model.dart';
import 'package:UpDown/features/root/home/data/repos/building_repo/building_repo.dart';
import 'package:either_dart/either.dart';

class BuildingRepoImp implements BuildingRepo {
  BuildingRepoImp(this.apiService);
  final ApiService apiService;
  @override
  BuildingModel? cash;

  @override
  Future<Either<Failure, BuildingModel>> fetchBuildingDetails(
      {required String buildingId}) async {
    if (cash != null) {
      return Right(cash!);
    }
    final result =
        await apiService.fetchBuildingDetails(buildingId: buildingId);
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
