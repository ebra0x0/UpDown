import 'package:UpDown/core/errors/failures.dart';
import 'package:UpDown/core/utils/api_service.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo.dart';
import 'package:either_dart/either.dart';

class BuildingsRepoImp implements BuildingsRepo {
  BuildingsRepoImp(this.apiService);
  final ApiService apiService;

  @override
  Future<Either<Failure, BuildingModel?>> fetchBuildingDetails(
      String buildingId) async {
    final result =
        await apiService.fetchBuildingDetails(buildingId: buildingId);

    return result.fold(
      (errMsg) => Left(errMsg),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, List<BuildingSummaryModel>?>> fetchBuildings() {
    final result = apiService.fetchBuildings();

    return result.fold(
      (errMsg) => Left(errMsg),
      (response) => Right(response),
    );
  }
}
